abstract class LoactionSearchState{}
class LocationSearchInitialState extends LoactionSearchState{}

class LocationSearchLoadingState extends LoactionSearchState{}
class LocationSearchFocusState extends LoactionSearchState{}


class LocationSearchLoadedState extends LoactionSearchState{
  final String pageType;
  LocationSearchLoadedState(this.pageType);
}