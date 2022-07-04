import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDavysGrey,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: kMikadoYellow,
        elevation: 0,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: const Alignment(
                  0,
                  -1,
                ),
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: kMikadoYellow,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: 300,
                    height: 380,
                    decoration: BoxDecoration(
                      color: kGrey,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: kMikadoYellow.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/ic_ditonton.png',
                          height: 200,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Ditonton merupakan sebuah aplikasi katalog film yang dibuat untuk menyelesaikan tugas KKP (Kuliah Kerja Praktek).',
                            //style: darkPurpleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 195,
                width: 250,
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: kMikadoYellow,
                      spreadRadius: 2,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 10,
                      ),
                      Text('Project KKP'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('1. ZEN FANNY PARULIAN P'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('2. DIAH NOVIANTI'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('3. RAFLI BAGAS HARTONO'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('4. DION SUNARDI'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('5. ARDI ARIAPUTRA JAELANI'),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
