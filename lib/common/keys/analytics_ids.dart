import 'package:fts/common/keys/page_ids.dart';

class AnalyticsId {
  const AnalyticsId(this.name, this.pageId);

  final String name;
  final PageId pageId;

  String toKey() => '${pageId.name}/$name';
}

abstract final class AnalyticsIds {
  static const onboardingContinueToAppButton = AnalyticsId(
    'OnboardingContinueToAppButton',
    PageId.onboarding,
  );
  static const openStorePageButton = AnalyticsId(
    'OpenStoreButton',
    PageId.forceUpdate,
  );
  static const cancelDialogButton = AnalyticsId(
    'CancelButton',
    PageId.suggestUpdateDialog,
  );
  static const openStoreDialogButton = AnalyticsId(
    'OpenStoreButton',
    PageId.suggestUpdateDialog,
  );
  static const throwExceptionButton = AnalyticsId(
    'ThrowExceptionButton',
    PageId.homePage,
  );
  static const loginButton = AnalyticsId('LoginButton', PageId.login);
  static const loginRegisterButton = AnalyticsId(
    'RegisterButton',
    PageId.login,
  );
  static const registerRegisterButton = AnalyticsId(
    'RegisterButton',
    PageId.register,
  );
  static const settingsRegisterButton = AnalyticsId(
    'RegisterButton',
    PageId.settings,
  );
  static const registerWithAppleButton = AnalyticsId(
    'RegisterWithAppleButton',
    PageId.register,
  );
  static const registerWithGoogleButton = AnalyticsId(
    'RegisterWithGoogleButton',
    PageId.register,
  );
  static const registerWithPasskeyButton = AnalyticsId(
    'RegisterWithPasskeyButton',
    PageId.register,
  );

  static const passkeyRegisterRegisterButton = AnalyticsId(
    'RegisterButton',
    PageId.registerWithPasskey,
  );

  static const passkeyRegisterLoginButton = AnalyticsId(
    'LoginButton',
    PageId.registerWithPasskey,
  );

  static const addNewPasskeyButton = AnalyticsId(
    'addNewPasskeyButton',
    PageId.passkeys,
  );

  static AnalyticsId socialContinueButton(PageId pageId) =>
      AnalyticsId('SocialContinueButton', pageId);

  static AnalyticsId socialCancelButton(PageId pageId) =>
      AnalyticsId('SocialCancelButton', pageId);
  static const loginWithAppleButton = AnalyticsId(
    'LoginWithAppleButton',
    PageId.login,
  );
  static const loginWithGoogleButton = AnalyticsId(
    'LoginWithGoogleButton',
    PageId.login,
  );
  static const loginWithPasskeyButton = AnalyticsId(
    'LoginWithPasskeyButton',
    PageId.login,
  );
  static const recoveryBackButton = AnalyticsId(
    'RecoveryBackButton',
    PageId.verify,
  );
  static const registerBackButton = AnalyticsId(
    'RegisterBackButton',
    PageId.register,
  );
  static const loginRecoveryButton = AnalyticsId(
    'RecoveryButton',
    PageId.login,
  );
  static const recoveryEmailButton = AnalyticsId(
    'RecoveryButton',
    PageId.recovery,
  );
  static const changePasswordButton = AnalyticsId(
    'MenuChangePasswordButton',
    PageId.menu,
  );
  static const menuUpdateProfile = AnalyticsId(
    'MenuUpdateProfile',
    PageId.menu,
  );
  static const menuDeleteAccount = AnalyticsId(
    'MenuDeleteAccount',
    PageId.menu,
  );
  static const reauthorizeNextButton = AnalyticsId(
    'ReauthorizeNextButton',
    PageId.reauthorize,
  );
  static const openExamples = AnalyticsId('OpenExamples', PageId.homePage);
  static const openQueryCubitExample = AnalyticsId(
    'OpenQueryCubitExample',
    PageId.examples,
  );
  static const openPaginatedQueryCubitExample = AnalyticsId(
    'OpenPaginatedQueryCubitExample',
    PageId.examples,
  );
  static const verifyResendOTP = AnalyticsId('VerifyResendOTP', PageId.verify);

  static AnalyticsId retryButton(PageId pageId) =>
      AnalyticsId('RetryButton', pageId);
  static const verifyResendFlow = AnalyticsId(
    'VerifyResendFlow',
    PageId.verify,
  );
  static const incrementButton = AnalyticsId(
    'IncrementButton',
    PageId.homePage,
  );
  static const nearbyServicesButton = AnalyticsId(
    'NearbyServicesButton',
    PageId.homePage,
  );
  static const loginVerifyResendButton = AnalyticsId(
    'LoginVerifyResendButton',
    PageId.verify,
  );
  static const recoveryVerifyResendButton = AnalyticsId(
    'RecoveryVerifyResendButton',
    PageId.recovery,
  );
  static const editProfileInformationButton = AnalyticsId(
    'editProfileInformationButton',
    PageId.profile,
  );

  //
  static const homePageViewAllButton = AnalyticsId(
    'homePageViewAllButton',
    PageId.homePage,
  );
  static const rateSessionButton = AnalyticsId(
    'rateSessionButton',
    // TODO: decide whether different AnalyticsId should be used if it's clicked on home
    PageId.agenda,
  );
  static const speakerLinkedInButton = AnalyticsId(
    'speakerLinkedInButton',
    PageId.speakerDetails,
  );
  static const bottomSheetCloseButton = AnalyticsId(
    'bottomSheetCloseButton',
    PageId.bottomSheet,
  );
  static const signUpToRateButton = AnalyticsId(
    'signUpToRateButton',
    PageId.bottomSheet,
  );
  static const signUpToRateCancelButton = AnalyticsId(
    'signUpToRateCancelButton',
    PageId.bottomSheet,
  );
  static const ratePopupSendButton = AnalyticsId(
    'ratePopupSendButton',
    PageId.ratePopup,
  );
  static const ratePopupCancelButton = AnalyticsId(
    'ratePopupCancelButton',
    PageId.ratePopup,
  );
  static const ratePopupStarButton = AnalyticsId(
    'ratePopupStarButton',
    PageId.ratePopup,
  );
  static const errorStateTryAgainButton = AnalyticsId(
    'errorStateTryAgainButton',
    PageId.errorState,
  );
  static const centerMapOnUserLocation = AnalyticsId(
    'centerMapOnUserLocation',
    PageId.map,
  );
  static const mapCardNavigate = AnalyticsId('mapCardNavigate', PageId.map);

  static const mapCardClose = AnalyticsId('mapCardClose', PageId.map);
}
