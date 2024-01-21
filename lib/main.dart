import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_mart/veiw/splash/splash_screen.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: darkFontGrey),
              elevation: 0,
              backgroundColor: Colors.transparent),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }
}
