from urllib import parse

import snakemd
import yaml
from snakemd import InlineText, MDList, Paragraph
from yaml.loader import SafeLoader


def main():
    with open('../bankuu-info-resource/information.yaml') as f:
        info = yaml.load(f, Loader=SafeLoader)

        # make out path
        doc = snakemd.new_doc("../../README")

        name = list(info['about']['name'].values())
        # -- Header
        doc.add_header(
            "🙏🏽 Sawandee [Hi] - I'm {name} [{other_name}]".format(name=name[0], other_name=', '.join(name[1:])), 3)

        # -- Create Contact Icons
        icon_format = '[![{text}](https://img.shields.io/badge/-{text}-{color}?' \
                      'style=flat-square&amp;labelColor={color}&amp;logoColor=white&amp;logo={logo})]({link}) '
        contact_icons = []

        for item in info['about']['contact'].values():
            contact_icons.append(
                icon_format.format(text=parse.quote(item['name']), color=item['color'], logo=item['shields-icon'],
                                   link=item['link']))
        doc.add_paragraph(' '.join(contact_icons))
        # --

        doc.add_paragraph("---")
        doc.add_header("🙋🏽 My Facts", 3)

        currently_working = Paragraph([
            InlineText("🖥️ Currently working at {last_location}".format(
                last_location=info['experience'][0]['name']))]).insert_link(
            info['experience'][0]['name'], info['experience'][0]['link'],
        )

        livein = Paragraph([InlineText("🛌  Live in {location}".format(location=info['about']['livein']))])

        challenge = Paragraph(
            [
                "🗻 Challenge myself on ",
                ' '.join([
                    icon_format.format(text=parse.quote(item['name']), color=item['color'], logo=item['shields-icon'],
                                       link=item['link']) for item in
                    info['about']['challenge'].values()
                ])
            ]
        )

        blog = Paragraph(
            ["📑 Keep my knowledge at ",
             ' '.join(
                 [
                     icon_format.format(text=parse.quote(item['name']), color=item['color'], logo=item['shields-icon'],
                                        link=item['link']) for item in
                     info['about']['knowledge'].values()])
             ]
        )

        listen = Paragraph(["🎧 Music taste are {listen}".format(listen=", ".join(info['favourite']['listen']))])

        doc.add_element(MDList([currently_working, livein, challenge, blog, listen]))

        doc.add_paragraph("---")
        doc.add_header("💡 My Knowledge", 3)

        skill_icon = []
        skill_icon.extend(list(info['skill'].keys()))
        for key in info['skill'].keys():
            skill_icon.extend([library for library in info['skill'][key]['library']])
        doc.add_element(Paragraph(
            ['<img src="packages/bankuu-info-resource/image/skill-{icon}.png"/> '.format(icon=icon) for icon in
             skill_icon]),
        )

        # doc.add_paragraph('---')

        doc.output_page()


if __name__ == "__main__":
    main()
