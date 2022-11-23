import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  bool isMute = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: appBarProfile(context),
      endDrawer: drawerProfile(userProvider),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kGreenPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          ],
        ),
        ListView(children: [
          profile(userProvider),
        ]),
      ]),
    );
  }

  Drawer drawerProfile(userProvider) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.9),
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: [
          const DrawerHeader(
              padding: EdgeInsets.only(top: 40),
              child: ListTile(
                title: Text(
                  "E-Learning",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Layanan Digitalisasi Sekolah",
                  style: TextStyle(fontSize: 12),
                ),
              )),
          ListTile(
            leading: const Icon(
              Icons.lightbulb_outline,
              color: kGreenPrimary,
            ),
            title: const Text("Dark Mode"),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              icon: Icon(
                isDark ? Icons.toggle_on_rounded : Icons.toggle_off_outlined,
                size: 35,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.volume_mute_outlined,
                color: kGreenPrimary,
              ),
              title: const Text("Mute Notifikasi"),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isMute = !isMute;
                  });
                },
                icon: Icon(
                  isMute ? Icons.toggle_on_rounded : Icons.toggle_off_outlined,
                  size: 35,
                ),
              )),
          const ListTile(
            leading: Icon(
              Icons.layers,
              color: kGreenPrimary,
            ),
            title: Text("Versi 1.0.0"),
          ),
          ListTile(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("E-Learning", style: TextStyle( fontWeight: FontWeight.bold),),
                          Text("Layanan Digitalisasi Sekolah", style: TextStyle(fontSize: 12),),
                          // Divider(height: 1,color: kGreenPrimary,),
                        ],
                      ),
                      content: const Text(
                        "E-Learning. Aplikasi berbasis Mobile Apps yang mendukung akan produktivitas dalam pekerjaan diperkuliahan.",
                      ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("Tutup", style: TextStyle(color: kGreenPrimary),))
                  ],
                    )),
            leading: const Icon(
              Icons.info_outline,
              color: kGreenPrimary,
            ),
            title: const Text("About"),
          ),
          ListTile(
            onTap: () {
              userProvider.logout(context);
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Keluar",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}

PreferredSizeWidget appBarProfile(BuildContext context) {
  return AppBar(
      backgroundColor: kWhiteBg,
      foregroundColor: Colors.black,
      toolbarHeight: 110,
      elevation: 0,
      centerTitle: true,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
      title: const Text(
        'Profile',
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xff06283D)),
      ));
}

Widget profile(UserProvider userProvider) {
  return FutureBuilder(
    future: userProvider.getProfileUser(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const SkeltonProfile();
      }
      var d = snapshot.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    "https://elearning.itg.ac.id/upload/avatar/${d['avatar']}"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d['nama'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  Text(
                      d['user']['user_type'] == 'siswa'
                          ? "Mahasiswa"
                          : d['user']['user_type'],
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xff06283D))),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kWhiteBg,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardProfile(
                  title: "NIM",
                  value: d["nim"],
                ),
                CardProfile(
                  title: "Semester",
                  value: d["tingkat"]['nama'],
                ),
                CardProfile(
                  title: "Kelas",
                  value: d["kelas"][0]['nama'],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Profile(
                icon: Icons.email_outlined,
                title: "Email",
                subtitle: d['email'],
              ),
              Profile(
                icon: Icons.bookmarks_sharp,
                title: "Program Studi",
                subtitle: d['email'],
              ),
              Profile(
                icon: Icons.phone_android,
                title: "No Telepon",
                subtitle: d['no_hp'],
              ),
              Profile(
                icon: Icons.calendar_month_outlined,
                title: "Tempat, Tanggal Lahir",
                subtitle: "${d['tempat_lahir']}, ${d['tanggal_lahir']}",
              ),
            ],
          )
        ],
      );
    },
  );
}

class CardProfile extends StatelessWidget {
  String? title;
  String? value;
  CardProfile({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, color: kGreen)),
          const SizedBox(
            height: 10,
          ),
          Text(
            value!,
            style: const TextStyle(fontWeight: FontWeight.w700, color: kGreen),
          ),
        ],
      ),
    );
  }
}
