import 'package:flutter/material.dart';

class MyNavigator {
  static void goToMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
  }

  static void goChangePassword(BuildContext context) {
    Navigator.pushNamed(context, "/change_password");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  static void goToHistory(BuildContext context) {
    Navigator.pushNamed(context, '/history');
  }

  static void goToMyRating(BuildContext context) {
    Navigator.pushNamed(context, '/myRating');
  }

  static void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  static void goToUpdateProfile(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/updateProfile', (Route<dynamic> route) => false);
  }

  static void goToVerifyIdentity(BuildContext context) {
    Navigator.pushNamed(context, "/verifyIdentity");
  }

  static void goToDashboard(BuildContext context) {
    goToMain(context);
  }

  static void goToForgetPassword(BuildContext context) {
    Navigator.pushNamed(context, "/forgot_password");
  }

  static void goToTermsOfUse(BuildContext context) {
    Navigator.pushNamed(context, "/termsOfUse");
  }

  static void goToDetailCompany(BuildContext context) {
    Navigator.pushNamed(context, "/detail_company");
  }

  static void goToVerifyAccount(BuildContext context) {
    Navigator.pushNamed(context, "/verify_account");
  }

  static void goToExchange(BuildContext context) {
    Navigator.pushNamed(context, "/exchange");
  }

  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }

  static void goToMyProfile(BuildContext context) {
    Navigator.pushNamed(context, "/my_profile");
  }

  static void goToRating(BuildContext context) {
    Navigator.pushNamed(context, "/rating");
  }

  static void goDetailJob(BuildContext context) {
    Navigator.pushNamed(context, "/detail_job");
  }

  static void goToImageView(BuildContext context, String url) {
    Navigator.pushNamed(context, "/image_view");
  }

  static void goToSetting(BuildContext context) {
    Navigator.pushNamed(context, "/setting");
  }

  static void goProfileCandidate(BuildContext context) {
    Navigator.pushNamed(context, "/profile_candidate");
  }

  static void goJobResults(BuildContext context) {
    Navigator.pushNamed(context, "/job_results");
  }

  static void goJobResultsDetail(BuildContext context) {
    Navigator.pushNamed(context, "/job_results_detail");
  }

  static void goToExchangeGetMoney(BuildContext context) {
    Navigator.pushNamed(context, "/exchange_get_money");
  }

  static void goRecharge(BuildContext context) {
    Navigator.pushNamed(context, "/recharge");
  }
}
