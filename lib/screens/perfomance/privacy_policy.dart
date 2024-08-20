import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Text("Privacy Policy",style: GoogleFonts.irishGrover(
          color: Colors.white
        ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context).pop, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),


      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          ), 
          color: Colors.yellow.shade100
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Privacy Policy', style: GoogleFonts.irishGrover(

                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(height: 20),
                Text(
                  'We built  CONNECT - The Mini Scheduler-To-do-app as a Free app. This SERVICE is provided by us at no cost and is intended for use as is.\n\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\n\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.',
                  style: GoogleFonts.irishGrover(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Text('Information We Collect',
                      style: GoogleFonts.irishGrover(
                        fontWeight: FontWeight.bold,
                  fontSize: 20

                      )),
                ),
                Text(
                  'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name and photo. The information that we request will be retained by us and used as described in this privacy policy.',
                  style: GoogleFonts.irishGrover(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Photos',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                  'CONNECT - The Mini Scheduler-To-Do app may allow you to upload photos for use within the app. These photos are stored locally on your device and are not transmitted to external servers.',
                  style: GoogleFonts.irishGrover(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Log Data',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                    'We want to inform you that whenever you use our Service, in a case of an error in the app, we may collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
                    style: GoogleFonts.irishGrover()),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Information Sharing',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                    'The app may not share your personal information with any third-party services or vendors.\n\nWe may disclose your personal information if required to do  so by law or in response to valid legal requests from government authorities or law enforcement agencies.',
                    style: GoogleFonts.irishGrover()),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Security',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                  'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.',
                  style: GoogleFonts.irishGrover(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Children\'s privacy',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                    'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to take necessary actions.',
                    style: GoogleFonts.irishGrover()),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Changes to This Privacy Policy',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                  'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n\n This policy is effective as of 23-Apr-2024.',
                  style: GoogleFonts.irishGrover(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.irishGrover(
                      fontWeight: FontWeight.bold,
                  fontSize: 20
                    ),
                  ),
                ),
                Text(
                    'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us  002akashakz@gmail.com',
                    style: GoogleFonts.irishGrover())
              ],
            ),
          ),
        ),

      ),
    
    );


  }
}