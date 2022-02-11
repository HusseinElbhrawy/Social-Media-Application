abstract class SocialAppStates {}

class InitialState extends SocialAppStates {}

class RegisterInitialState extends SocialAppStates {}

class ChangeLoginPasswordStateFromShowToHidden extends SocialAppStates {}

class ChangeRegisterPasswordStateFromShowToHidden extends SocialAppStates {}

class LoginLoadingState extends SocialAppStates {}

class PleaseVerifyYourAccountState extends SocialAppStates {}

class LoginSuccessState extends SocialAppStates {
  final bool isEmailVerified;

  LoginSuccessState(this.isEmailVerified);
}

class LoginFailState extends SocialAppStates {
  final String messageError;

  LoginFailState(this.messageError);
}

class RegisterLoadingState extends SocialAppStates {}

class RegisterSuccessState extends SocialAppStates {}

class RegisterFailState extends SocialAppStates {
  final String messageError;

  RegisterFailState(this.messageError);
}

class CreateUserLoadingState extends SocialAppStates {}

class CreateUserSuccessState extends SocialAppStates {}

class CreateUserFailState extends SocialAppStates {
  // final String messageError;
  //
  // CreateUserFailState(this.messageError);
}

class HomeScreenInitialState extends SocialAppStates {}

class GetCurrentUserLoading extends SocialAppStates {}

class GetCurrentUserSuccess extends SocialAppStates {}

class GetCurrentUserFail extends SocialAppStates {}

class SendVerificationEmailLoading extends SocialAppStates {}

class SendVerificationEmailSuccess extends SocialAppStates {}

class SendVerificationEmailFail extends SocialAppStates {
  final String errorMessage;

  SendVerificationEmailFail(this.errorMessage);
}

class SignOutLoading extends SocialAppStates {}

class SignOutSuccess extends SocialAppStates {}

class SignOutFail extends SocialAppStates {}

class ChangeBottomNavigationIndex extends SocialAppStates {}

class OpenAddNewPostScreen extends SocialAppStates {}

class SettingScreenInitialState extends SocialAppStates {}

class GetCurrentUserUId extends SocialAppStates {}

//Get Current User data from database
class GetCurrentUserDataLoading extends SocialAppStates {}

class GetCurrentUserDataFail extends SocialAppStates {}

class GetCurrentUserDataSuccess extends SocialAppStates {}

class EditScreenInitialState extends SocialAppStates {}

//Picked Profile image and cover  States
class PickedProfileImageLoading extends SocialAppStates {}

class PickedProfileImageSuccess extends SocialAppStates {}

class PickedProfileImageFail extends SocialAppStates {}

class PickedProfileCoverLoading extends SocialAppStates {}

class PickedProfileCoverSuccess extends SocialAppStates {}

class PickedProfileCoverFail extends SocialAppStates {}

//Upload Images to Storage   States
class UploadImageToStorageLoading extends SocialAppStates {}

class UploadImageToStorageSuccess extends SocialAppStates {}

class UploadImageToStorageFail extends SocialAppStates {}

//Update Database  States
class UpdateChangesLoading extends SocialAppStates {}

class UpdateChangesSuccess extends SocialAppStates {}

class UpdateChangesFail extends SocialAppStates {}

class ChangeEditUserInformationState extends SocialAppStates {}

//Create Post States
class CreatePostScreenInitialState extends SocialAppStates {}

class CreatePostLoading extends SocialAppStates {}

class CreatePostSuccess extends SocialAppStates {}

class CreatePostFail extends SocialAppStates {}

//Picked Image For post

class PickedImageForPostLoading extends SocialAppStates {}

class PickedImageForPostSuccess extends SocialAppStates {}

class PickedImageForPostFail extends SocialAppStates {}

//Upload Picked Image For post

class UploadPickedImageForPostLoading extends SocialAppStates {}

class UploadPickedImageForPostSuccess extends SocialAppStates {}

class UploadPickedImageForPostFail extends SocialAppStates {}

//Clear Selected image for post
class ClearSelectedImageForPost extends SocialAppStates {}

//Feeds Screen initial State
class FeedsScreenInitialState extends SocialAppStates {}

//Add Like to post states

class AddLikeToPostLoading extends SocialAppStates {}

class AddLikeToPostSuccess extends SocialAppStates {}

class AddLikeToPostFail extends SocialAppStates {}
//Add Comment to post states

class AddCommentToPostLoading extends SocialAppStates {}

class AddCommentToPostSuccess extends SocialAppStates {}

class AddCommentToPostFail extends SocialAppStates {}
