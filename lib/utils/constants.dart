class Constants {
  static const baseHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "withCredentials": "true",
  };
  //Constantes here
  static const baseURL = "http://192.168.4.183:8000"; //192.168.1.41
  // static const baseURL = "https://bloodglucosemeasure.herokuapp.com"; //192.168.1.41

  static const csrfCookie = "$baseURL/sanctum/csrf-cookie";
  static const logInURL = "$baseURL/api/login";
  static const user = "$baseURL/api/user";

  //Daily Data
  static const createDailyData = "$baseURL/api/daily-data";

  //Meal
  static const createMealURL = "$baseURL/api/meal";

  //Sleep
  static const createSleepURL = "$baseURL/api/sleep";

  //Sport
  static const createSportURL = "$baseURL/api/sport";

  //Insulin
  static const createInsulinURL = "$baseURL/api/insulin";

  // User Profile
  static const updateUserProfileURL = "$baseURL/api/user/profile";

  // static const double MY_DIALOG_BOX_PADDING = 5;
  // static const double  MY_DIALOG_BOX_AVATAR_RADIUS = 45;

}
