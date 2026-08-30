import 'package:deposit_calc_satelit/core/network/api_path.dart';
import 'package:deposit_calc_satelit/core/utils/random_string_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:deposit_calc_satelit/core/constants/constants.dart';
import 'package:deposit_calc_satelit/core/di/service_locator.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/core/theme/theme.dart';
import 'package:deposit_calc_satelit/gen/l10n.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String globalUserId;

AppMetricaConfig get _config =>
    const AppMetricaConfig(ApiPath.appMetrikaConfigKey, logs: false);
final appNavigatorKey = GlobalKey<NavigatorState>();
final appRouter = AppRouter(appNavigatorKey);
String? payloadToHandle;

void main() async {
  AppMetrica.runZoneGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    /*  await AppMetrica.activate(_config); */
    await initServiceLocator();
    /*  await AppBannerInitialSetup().getPackageInfo();
    await AppBannerInitialSetup().getBanner(); 
    await connectNotificationsLogic();*/
    globalUserId =
        GetIt.I<SharedPreferences>().getString('userIdMetrika') ?? '';

    if (globalUserId.isEmpty) {
      globalUserId = await AppMetrica.deviceId ?? generateRandomString();

      await GetIt.I<SharedPreferences>().setString(
        'userIdMetrika',
        globalUserId,
      );
    }
    runApp(
      const App(),
    );
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      child: MaterialApp.router(
        locale: const Locale(languageCode),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        routerConfig: appRouter.config(),
        supportedLocales: const AppLocalizationDelegate().supportedLocales,
        theme: defaultTheme,
      ),
    );
  }
}
