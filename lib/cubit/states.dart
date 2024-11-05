
abstract class TodoStates{}
class InitState extends TodoStates {}


class InsertLoadingState extends TodoStates {}
class InsertSuccessState extends TodoStates {}
class InsertErrorState extends TodoStates {}


class UpdateLoadingState extends TodoStates {}
class UpdateSuccessState extends TodoStates {}
class UpdateErrorState extends TodoStates {}


class GetRecordLoadingState extends TodoStates {}
class GetRecordSuccessState extends TodoStates {}



class DeleteSucessState extends TodoStates {}
class DeleteErrorState extends TodoStates {}


class ChangeCurrentIndexState extends TodoStates {}


class ChangeBottomSheetState extends TodoStates {}