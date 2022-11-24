import 'package:e_learning/providers/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/theme.dart';
import '../widget/profile.dart';

class ProfileScreen extends StatefulWidget {
  var data;
  ProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  bool isMute = false;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: appBarProfile(context),
      endDrawer: drawerProfile(userProvider, themeProvider),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.65,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          ],
        ),
        SingleChildScrollView(child: profile(widget.data, context)),
      ]),
    );
  }

  Drawer drawerProfile(UserProvider userProvider, ThemeProvider themeProvider) {
    var theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: [
          DrawerHeader(
              padding: EdgeInsets.only(top: 40),
              child: ListTile(
                title: Text(
                  "E-Learning",
                  style: theme.textTheme.headline1,
                ),
                subtitle: Text(
                  "Layanan Digitalisasi Sekolah",
                  style: theme.textTheme.subtitle1,
                ),
              )),
          ListTile(
            leading: const Icon(
              Icons.lightbulb_outline,
              color: kGreenPrimary,
            ),
            title: Text(
              "Dark Mode",
              style: theme.textTheme.subtitle1,
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  themeProvider.changeTheme(isDark ? "light" : "dark");
                  isDark = !isDark;
                });
              },
              icon: Icon(
                isDark ? Icons.toggle_on_rounded : Icons.toggle_off_outlined,
                size: 35,
                color: theme.primaryColor,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.volume_mute_outlined,
                color: kGreenPrimary,
              ),
              title: Text(
                "Mute Notifikasi",
                style: theme.textTheme.subtitle1,
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isMute = !isMute;
                  });
                },
                icon: Icon(
                  isMute ? Icons.toggle_on_rounded : Icons.toggle_off_outlined,
                  size: 35,
                  color: theme.primaryColor,
                ),
              )),
          ListTile(
            leading: const Icon(
              Icons.layers,
              color: kGreenPrimary,
            ),
            title: Text("Versi 1.0.0", style: theme.textTheme.subtitle1),
          ),
          ListTile(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      backgroundColor: theme.scaffoldBackgroundColor,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "E-Learning",
                            style: theme.textTheme.headline2,
                          ),
                          Text(
                            "Layanan Digitalisasi Sekolah",
                            style: theme.textTheme.subtitle1,
                          ),
                          // Divider(height: 1,color: kGreenPrimary,),
                        ],
                      ),
                      content: Text(
                        "E-Learning. Aplikasi berbasis Mobile Apps yang mendukung akan produktivitas dalam pekerjaan diperkuliahan.",
                        style: theme.textTheme.subtitle1,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Tutup",
                              style: TextStyle(color: kGreenPrimary),
                            ))
                      ],
                    )),
            leading: const Icon(
              Icons.info_outline,
              color: kGreenPrimary,
            ),
            title: Text("About", style: theme.textTheme.subtitle1),
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
  var theme = Theme.of(context);
  return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.primaryColor,
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
      title: Text(
        'Profile',
        style: theme.textTheme.headline1,
      ));
}

Widget profile(d, context) {
  var theme = Theme.of(context);
  return d == null
      ? const Center(child: CircularProgressIndicator())
      : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: "avatar",
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://elearning.itg.ac.id/upload/avatar/${d['avatar']}"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d['nama'], style: theme.textTheme.headline3),
                    Text(
                        d['user']['user_type'] == 'siswa'
                            ? "Mahasiswa"
                            : d['user']['user_type'],
                        style: theme.textTheme.subtitle1)
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
                color: theme.primaryColorDark,
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
