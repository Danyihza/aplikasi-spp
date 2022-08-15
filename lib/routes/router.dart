import 'package:flutter_app/resources/pages/history_by_id_page.dart';
import 'package:flutter_app/resources/pages/historypayment_page.dart';
import 'package:flutter_app/resources/pages/historypayments_by_id_page.dart';
import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:flutter_app/resources/pages/home_siswa_page.dart';
import 'package:flutter_app/resources/pages/login_page.dart';
import 'package:flutter_app/resources/pages/pred_page.dart';
import 'package:flutter_app/resources/pages/student_add_page.dart';
import 'package:flutter_app/resources/pages/student_page.dart';

import 'package:nylo_framework/nylo_framework.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "flutter pub run nylo_framework:main make:page my_page"
| Learn more https://nylo.dev/docs/3.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
      // router.route("/", (context) => MyHomePage(title: "Hello World"));
      router.route("/", (context) => LoginPage());
      router.route("/home", (context) => HomePage());
      router.route("/home/siswa", (context) => HomeSiswaPage());
      router.route("/pred", (context) => PredPage());
      router.route("/historypayment", (context) => HistorypaymentPage());
      router.route("/historypaymentbyid", (context) => HistorypaymentsByIdPage());
      router.route("/student", (context) => StudentPage());
      router.route("/student/add", (context) => StudentAddPage());

      // Add your routes here

      // router.route("/new-page", (context) => NewPage(), transition: PageTransitionType.fade);
    });
