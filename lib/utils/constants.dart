class Constants {
  static const baseHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "withCredentials": "true",
  };
  //Constantes here
  static const baseURL = "http://192.168.1.143:8000";

  static const csrfCookie = "$baseURL/sanctum/csrf-cookie";
  static const logInURL = "$baseURL/api/login";
  static const user = "$baseURL/api/user";

  //Daily Data
  static const addDailyData = "$baseURL/api/daily-data";

  //Meal
  static const addMealURL = "$baseURL/api/meal/";

  // static const ALERTE_URL = "$BASE_URL/controles/liste";
  // static const RAPPORT_URL = "$BASE_URL/nmpf/stats";
  // static const LOG_OUT_URL = "$BASE_URL/mon_espace/deconnexion";

  // static const double MY_DIALOG_BOX_PADDING = 5;
  // static const double  MY_DIALOG_BOX_AVATAR_RADIUS = 45;

}
