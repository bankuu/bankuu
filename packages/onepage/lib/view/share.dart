import 'package:bankuu_info_site/utility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareView {
  static Widget buildButtonBar(BuildContext context) {
    final Uri url = Uri(scheme: 'mailto', path: 'ban.kuu@yahoo.com', query: 'subject=Contact to  バンクー');
    return Container(
      alignment: Alignment.bottomCenter,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(colors: [
          ColorSet.textBegin.color,
          ColorSet.textEnd.color,
        ]).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text.rich(
          TextSpan(children: [
            const TextSpan(text: "Create with L#v : bankuu (", style: TextStyle(fontSize: 20)),
            TextSpan(
              text: "ban.kuu@yahoo.com",
              mouseCursor: SystemMouseCursors.click,
              style: const TextStyle(fontSize: 20),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
            ),
            const TextSpan(text: ")", style: TextStyle(fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}
