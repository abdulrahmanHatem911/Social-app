abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

// to get all users

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

// for get posts

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

// state for likes

class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {
  final String error;
  SocialLikePostsErrorState(this.error);
}

// state for Comment

class SocialCommentPostsSuccessState extends SocialStates {}

class SocialCommentPostsErrorState extends SocialStates {
  final String error;
  SocialCommentPostsErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostNavState extends SocialStates {}

// for profile image
class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialStates {}

// for cover image
class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {}

// for upload profile image
class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

// for upload caver image
class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadErrorState extends SocialStates {}

class SocialUploadLoadingState extends SocialStates {}

// for the post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

// for post image
class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialPostImagePickedRemoveState extends SocialStates {}
