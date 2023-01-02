import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'O nas'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage("images/logoDark.png"),
                        fit: BoxFit.fitHeight
                    ),
                  ),
                ),
              ),
              sectionTitle('Informacje'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                    color: AppColors.dutchWhite.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
                      child: Text('Witamy w naszej kawiarni! Jesteśmy przytulną małą kawiarnią położoną w samym sercu śródmieścia, której celem jest zapewnienie naszym klientom doskonałej filiżanki kawy. Nasz zespół wykwalifikowanych baristów jest pasjonatem sztuki parzenia kawy i zobowiązuje się do używania tylko najlepszych ziaren i składników w każdej filiżance.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text('Witamy w naszej kawiarni! Jesteśmy przytulną małą kawiarnią położoną w samym sercu śródmieścia, której celem jest zapewnienie naszym klientom doskonałej filiżanki kawy. Nasz zespół wykwalifikowanych baristów jest pasjonatem sztuki parzenia kawy i zobowiązuje się do używania tylko najlepszych ziaren i składników w każdej filiżance.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text('W naszej kawiarni wierzymy w siłę społeczności i wagę więzi międzyludzkich. Dlatego stworzyliśmy przyjazną przestrzeń, w której ludzie mogą się spotykać, by napić się pysznej kawy i porozmawiać. Niezależnie od tego, czy jesteś stałym gościem, czy też odwiedzasz go po raz pierwszy, zawsze będziesz witany z uśmiechem i traktowany jak jeden z nas.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text('Oprócz naszej fachowo przygotowanej kawy oferujemy również szeroki wybór smacznych wypieków i kanapek przygotowywanych codziennie na świeżo. Niezależnie od tego, czy potrzebujesz szybkiego podrywu, czy chcesz spędzić wolny czas podczas lunchu, mamy coś dla Ciebie.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text('Jesteśmy dumni z bycia częścią społeczności śródmieścia i jesteśmy zaangażowani we wspieranie lokalnych firm i organizacji. Regularnie organizujemy wydarzenia i zbiórki pieniędzy i zawsze szukamy nowych sposobów, aby odwdzięczyć się i wywrzeć pozytywny wpływ.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                      child: Text('Dziękujemy, że zechcieli Państwo odwiedzić naszą kawiarnię. Nie możemy się doczekać, aby zaserwować Ci idealną filiżankę kawy i być częścią Twojego dnia.', textAlign: TextAlign.justify,style: infoTextStyle),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(color: AppColors.darkGoldenrod, thickness: 2.0),
              ),
              sectionTitle('Godziny otwarcia'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                    color: AppColors.dutchWhite.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee, color: AppColors.darkGoldenrod),
                        ),
                        Text('Poniedziałek', style: openInfoTextStyle),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyle)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee_outlined, color: AppColors.darkCoffe),
                        ),
                        Text('Wtorek', style: openInfoTextStyleDark),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyleDark)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee, color: AppColors.darkGoldenrod),
                        ),
                        Text('Środa', style: openInfoTextStyle),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyle)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee_outlined, color: AppColors.darkCoffe),
                        ),
                        Text('Czwartek', style: openInfoTextStyleDark),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyleDark)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee, color: AppColors.darkGoldenrod),
                        ),
                        Text('Piątek', style: openInfoTextStyle),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyle)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee_outlined, color: AppColors.darkCoffe),
                        ),
                        Text('Sobota', style: openInfoTextStyleDark),
                        const Spacer(),
                        Text('8:00 - 20:00', style: openInfoTextStyleDark)
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 10.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.coffee, color: AppColors.darkGoldenrod),
                        ),
                        Text('Niedziela', style: openInfoTextStyle),
                        const Spacer(),
                        Text('8:00 - 18:00', style: openInfoTextStyle)
                      ],),
                    ),
                  ]
                ) 
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(color: AppColors.darkGoldenrod, thickness: 2.0),
              ),
              sectionTitle('Tu nas znajdziesz'),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      color: AppColors.dutchWhite.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(Icons.facebook_outlined, color: AppColors.darkGoldenrod, size: 50.0),
                              Text('Facebook', style: openInfoTextStyle, textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Icon(Icons.camera_alt_outlined, color: AppColors.darkCoffe, size: 50.0),
                              Text('Instagram', style: openInfoTextStyleDark, textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.home_outlined, color: AppColors.darkGoldenrod, size: 50.0),
                              Text('Strona internetowa', style: openInfoTextStyle, textAlign: TextAlign.center),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(color: AppColors.darkGoldenrod, thickness: 2.0),
              ),
              sectionTitle('Kontakt'),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                    color: AppColors.dutchWhite.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.phone_outlined, color: AppColors.darkGoldenrod),
                          Text('Numer telefonu', style: openInfoTextStyle, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      child: Row(children:[Text('123 123 123', textAlign: TextAlign.start, style: openInfoTextStyleDark)]),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: AppColors.darkGoldenrod),
                          Text('Adres e-mail', style: openInfoTextStyle, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      child: Row(children:[Text('kawiarnia@example.com', textAlign: TextAlign.start, style: openInfoTextStyleDark)]),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(color: AppColors.burlyWood),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.coffee_maker_outlined, color: AppColors.darkGoldenrod),
                          Text('Adres lokalu', style: openInfoTextStyle, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 15.0),
                      child: Row(children:[Text('20 - 618 Lublin, ul. Przyrzeczna 25/2', textAlign: TextAlign.start, style: openInfoTextStyleDark)]),
                    )
                  ],
                )
              ),
            ],
          ),
        )
    );
  }

  TextStyle infoTextStyle = const TextStyle(
    fontSize: 17.0
  );

  TextStyle openInfoTextStyle= const TextStyle(
      color: AppColors.darkGoldenrod,
      fontWeight: FontWeight.bold,
      fontSize: 18.0
  );

  TextStyle openInfoTextStyleDark = const TextStyle(
      color: AppColors.darkCoffe,
      fontWeight: FontWeight.bold,
      fontSize: 18.0
  );
}
