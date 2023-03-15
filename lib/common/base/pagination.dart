class Pagination {
  int _page = 1;
  int _size = 20;
  int _total = 0;
  bool _hasNext = true;

  Pagination({int size = 20}) {
    _size = size;
    _hasNext = true;
    _page = 1;
  }

  bool get hasNext => _hasNext;
  int get page => _page;

  int get size => _size;

  set setNext(int totalPage) {
    _total = totalPage;
    _page++;
    if (_page < _total) {
      _hasNext = true;
    } else {
      _hasNext = false;
    }
  }
}
