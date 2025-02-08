class ApiUrlConstants {

  static const String BASE_URL = "https://apiuat-novo.enpointe.io/api";


  static const String register = "/auth/register";
  static const String login = "/auth/login";

  static const String googleLogin = "/auth/google-auth";
  static const String googleSignup = "/auth/create-google-user";
  static const String facebookLogin = "/auth/facebook-auth";
  static const String facebookSignup = "/auth/create-facebook-user";

  static const String guestUser = "/auth/guest-user";



  static const String getUserDetails = "/user/user-details";
  static const String getUserBookingHistoryDetails = "/user/booking-history";
  static const String getUserUpComingBooking = "/booking/upcoming-bookings";
  static const String getUserUpComingBookingDetails = "/booking/booking-details/";

  static const String forgotPassword = "/auth/forget-password-otp";
  static const String emailVerification = "/auth/email-verification-otp";

  static const String validateResetOtp = "/auth/validate-reset-otp";
  static const String verifyEmailOtp = "/auth/verify-email-otp";
  static const String resetPassword = "/auth/update-password";

  static const String getAllMovies = "/home/movies";
  static const String search = "/home/search";
  static const String quickBook = "/home/quick-book";
  static const String getAllBanners = "/home/banners";
  static const String likeMovie = "/home/movies/toggle-like";
  static const String likeCinema = "/home/cinemas/toggle-like";
  static const String nationalities = "/home/nationalities";
  static const String cinemas = "/home/cinemas";
  static const String cities = '/home/city';

  static const String getAllMoviesWithSession = "/home/all-sessions";


  static const String getMovieDetails = "/home/movie-details/";
  static const String getSessionDates = "/home/available-dates/";
  static const String createSession = "/home/sessions/";
  static const String getSeatLayout = "/booking/seat-layout/";
  static const String getAllOffers = "/booking/offers/";
  static const String validateBankOffers = "/booking/offers/validate";
  static const String applyBankOffers = "/booking/offers/apply";
  static const String removeAppliedBankOffers = "/booking/offers/remove";

  static const String applyDiscountCode = "/booking/offers/discount/apply";
  static const String removeDiscountCode = "/booking/offers/discount/remove";

  static const String bookSelectedSeat = "/booking/select-seats";
  static const String extendSeatBookingTimer = "/booking/reset-order";
  static const String cancelBookedSelectedSeat = "/booking/cancel-transaction/";
  static const String completeOrder = "/booking/complete-order";
  static const String getReservationDetails = "/booking/reservation-details/";


  static const String applyVoucherCode = "/booking/offers/payment-voucher/apply";
  static const String removeVoucherCode = "/booking/offers/payment-voucher/remove";



  static const String getAllFoodAndBevRage = "/booking/concessions";
  static const String postAllOnlyFoodAndBevRage = "/booking/concessions/only-concession";

  static const String getAllGiftCard = "/gifts-wallets/gift-cards/all";
  static const String buyGiftCard = "/gifts-wallets/gift-card/buy";
  static const String applyGiftCard = "/gifts-wallets/gift-card/apply";
  static const String removeGiftCard = "/gifts-wallets/gift-card/remove";
  static const String getBalanceGiftCard = "/gifts-wallets/gift-card/balance/";
  static const String topUpGiftCard = "/gifts-wallets/gift-card/topup";
  static const String sendReceivedGiftCard = "/gifts-wallets/gift-card/send-received";

  static const String pages = "/home/pages";

  static const String cineexperiences = '/home/cinema-experiences';

  // https://apiuat-novo.enpointe.io/api/booking/offers/discount/apply
  // https://apiuat-novo.enpointe.io/api/booking/offers/discount/remove

  static const String createPrivateScreening = '/private-screening';
  static const String getPrivateSessions = '/booking/free-sessions/movie/';
  static const String updatePrivateScreening = '/private-screening/2';
  static const String uploadMediaPrivate = '/upload/media';
  static const String getPrivateScreenPrice =
      '/booking/private-screening/total-cost/cinema/1/session';
  //MY Wallet
  static const String getWalletBalance =
      "/gifts-wallets/wallet/check-balance"; // -GET
  static const String topUpWalletBalance =
      '/gifts-wallets/wallet/topup'; // -POST
  static const String getWalletTransactions =
      '/gifts-wallets/wallet/transactions'; // -GET
  static const String completeWalletTopUp = '/booking/complete-order'; // -POST
}
