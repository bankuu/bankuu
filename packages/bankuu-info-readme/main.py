import yaml
import snakemd
from snakemd import InlineText, MDList, Paragraph
from yaml.loader import SafeLoader


def main():
    with open('../bankuu-info-resource/information.yaml') as f:
        info = yaml.load(f, Loader=SafeLoader)
        doc = snakemd.new_doc("../../README")
        name = list(info['about']['name'].values())
        # -- Header
        doc.add_header("🙏🏽 Sawandee [Hi] - I'm {name} [{other_name}]".format(name=name[0], other_name=', '.join(name[1:])), 3)

        # -- Create Contact Icons
        icon_format = '<img src="https://img.shields.io/badge/-{text}-{color}?style=flat-square&amp;labelColor={color}&amp;' \
                      'logoColor=white&amp;logo={logo}&amp;link={link}" style="max-width: 100%;">'
        contact_icons = []
        for key in info['about']['contact']:
            item = info['about']['contact'][key]
            contact_icons.append(icon_format.format(text=key.capitalize(), color=item['color'], logo=item['shields-icon'], link=item['link']))
        doc.add_paragraph(' '.join(contact_icons))
        # --

        doc.add_paragraph("---")
        doc.add_header("🙋🏽 My Facts", 3)

        currently_working = Paragraph([InlineText("🖥️ Currently working at {last_location}".format(last_location=info['experience'][0]['name']))]).insert_link(
            info['experience'][0]['name'], info['experience'][0]['link'],
        )

        side_project = [InlineText("🏗️ Side project is ")]
        side_project.extend([InlineText(item['name']).link(item['link']) for item in info['side-project']])
        side_project = Paragraph(side_project)

        blog = Paragraph(["📑 Keep my knowledge at ", InlineText("Hashnode").link(info['about']['contact']['hashnode']['link'])])

        listen = Paragraph(["🎧 Music taste are {listen}".format(listen=", ".join(info['favourite']['listen']))])

        doc.add_element(MDList([currently_working, side_project, blog, listen]))

        doc.add_paragraph("---")
        doc.add_header("💡 My Knowledge", 3)

        skill_icon = []
        skill_icon.extend(list(info['skill'].keys()))
        for key in info['skill'].keys():
            skill_icon.extend([library for library in info['skill'][key]['library']])
        doc.add_element(Paragraph(
            ['<img src="packages/bankuu-info-resource/image/skill-{icon}.png"/> '.format(icon=icon) for icon in skill_icon]),
        )
        doc.output_page()


if __name__ == "__main__":
    main()
