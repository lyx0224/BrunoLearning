import 'dart:ui';

import 'package:bruno/src/components/button/brn_big_main_button.dart';
import 'package:bruno/src/components/calendar/brn_calendar_view.dart';
import 'package:bruno/src/components/line/brn_line.dart';
import 'package:bruno/src/components/picker/time_picker/brn_date_time_formatter.dart';
import 'package:bruno/src/components/selection/bean/brn_selection_common_entity.dart';
import 'package:bruno/src/components/selection/brn_selection_util.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_date_range_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_menu_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_range_input_item_widget.dart';
import 'package:bruno/src/components/selection/widget/brn_selection_range_tag_widget.dart';
import 'package:bruno/src/components/tabbar/normal/brn_tab_bar.dart';
import 'package:bruno/src/components/toast/brn_toast.dart';
import 'package:bruno/src/constants/brn_asset_constants.dart';
import 'package:bruno/src/theme/configs/brn_selection_config.dart';
import 'package:bruno/src/utils/brn_event_bus.dart';
import 'package:bruno/src/utils/brn_text_util.dart';
import 'package:bruno/src/utils/brn_tools.dart';
import 'package:flutter/material.dart';

class BrnRangeSelectionGroupWidget extends StatefulWidget {
  static final double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;

  final BrnSelectionEntity entity;
  final double maxContentHeight;
  final bool showSelectedCount;
  final VoidCallback? bgClickFunction;
  final BrnOnRangeSelectionConfirm? onSelectionConfirm;

  final int? rowCount;

  final double marginTop;

  final BrnSelectionConfig themeData;

  BrnRangeSelectionGroupWidget(
      {Key? key,
      required this.entity,
      this.maxContentHeight = DESIGN_SELECTION_HEIGHT,
      this.rowCount,
      this.showSelectedCount = false,
      this.bgClickFunction,
      this.onSelectionConfirm,
      this.marginTop = 0,
      required this.themeData})
      : super(key: key);

  @override
  _BrnRangeSelectionGroupWidgetState createState() =>
      _BrnRangeSelectionGroupWidgetState();
}

class _BrnRangeSelectionGroupWidgetState
    extends State<BrnRangeSelectionGroupWidget>
    with SingleTickerProviderStateMixin {
  List<BrnSelectionEntity> _originalSelectedItemsList = [];
  List<BrnSelectionEntity> _firstList = [];
  List<BrnSelectionEntity> _secondList = [];
  int _firstIndex = -1;
  int _secondIndex = -1;
  int totalLevel = 0;

  late TabController _tabController;

  TextEditingController _minTextEditingController = TextEditingController();
  TextEditingController _maxTextEditingController = TextEditingController();

  bool _isConfirmClick = false;

  @override
  void initState() {
    _initData();
    _tabController = TabController(vsync: this, length: _firstList.length);
    if (_firstIndex >= 0) {
      _tabController.index = _firstIndex;
    }
    _tabController.addListener(() {
      _clearAllSelectedItems();
      _clearNotTagItem(totalLevel == 1
          ? _firstList
          : _firstList[_tabController.index].children);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (!_isConfirmClick) {
      _resetSelectionDatas(widget.entity);
      _clearNotTagItem(totalLevel == 1
          ? _firstList
          : _firstList[_tabController.index].children);
      _resetCustomMapData();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    totalLevel = BrnSelectionUtil.getTotalLevel(widget.entity);
    return GestureDetector(
      onTap: () {
        _backgroundTap();
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: _configWidgets(),
          ),
        ),
      ),
    );
  }

  //pragma mark -- config widgets

  List<Widget> _configWidgets() {
    List<Widget> widgetList = [];
    widgetList.add(_listWidget());
    return widgetList;
  }

  Widget _listWidget() {
    Widget? rangeWidget;

    if (_firstList.isNotEmpty && _secondList.isEmpty) {
      /// 1????????????????????????
      /// 1.2 ???????????? || ??????????????????????????????
      rangeWidget = _createNewTagAndRangeWidget(_firstList, Colors.white);
    } else if (_firstList.isNotEmpty && _secondList.isNotEmpty) {
      /// 2?????????????????????
      rangeWidget = _createNewTagAndRangeWidget(_firstList, Colors.white);
    }

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      constraints: _hasCalendarItem(widget.entity)
          ? BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom -
                  widget.marginTop)
          : BoxConstraints(
              maxHeight: widget.maxContentHeight + DESIGN_BOTTOM_HEIGHT),
      child: rangeWidget,
    );
  }

  Widget _createNewTagAndRangeWidget(
      List<BrnSelectionEntity> firstList, Color white) {
    if (firstList.isNotEmpty &&
        BrnSelectionUtil.getTotalLevel(widget.entity) == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _getOneTabContent(widget.entity)),
            ),
          ),
          BrnLine(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else if (firstList.isNotEmpty &&
        BrnSelectionUtil.getTotalLevel(widget.entity) == 2) {
      var tabBar = BrnTabBar(
        tabHeight: 50,
        controller: _tabController,
        tabs: firstList.map((f) => BadgeTab(text: f.title)).toList(),
      );
      var tabContent = SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _getOneTabContent(firstList[_tabController.index])));

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tabBar,
          Flexible(
            child: tabContent,
          ),
          BrnLine(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else {
      return Container();
    }
  }

  List<Widget> _getOneTabContent(BrnSelectionEntity filterItem) {
    List<BrnSelectionEntity> subFilterList = filterItem.children;

    /// TODO ???????????? Date  DateRange ??????????????????
    List<BrnSelectionEntity> tagFilterList = subFilterList
        .where((f) =>
            f.filterType != BrnSelectionFilterType.range &&
            f.filterType != BrnSelectionFilterType.date &&
            f.filterType != BrnSelectionFilterType.dateRange &&
            f.filterType != BrnSelectionFilterType.dateRangeCalendar)
        .toList();
    Size maxWidthSize = Size.zero;
    for (BrnSelectionEntity entity in subFilterList) {
      Size size = BrnTextUtil.textSize(entity.title,
          widget.themeData.tagNormalTextStyle.generateTextStyle());
      if (maxWidthSize.width < size.width) {
        maxWidthSize = size;
      }
    }

    int tagWidth;

    ///??????????????????????????????????????????????????????????????????????????????????????????????????????
    if (widget.rowCount == null) {
      int oneCountTagWidth =
          (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (1 - 1)) ~/ 1;
      int twoCountTagWidth =
          (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (2 - 1)) ~/ 2;
      int threeCountTagWidth =
          (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (3 - 1)) ~/ 3;
      int fourCountTagWidth =
          (BrnRangeSelectionGroupWidget.screenWidth - 40 - 12 * (4 - 1)) ~/ 4;
      if (maxWidthSize.width > twoCountTagWidth) {
        tagWidth = oneCountTagWidth;
      } else if (threeCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= twoCountTagWidth) {
        tagWidth = twoCountTagWidth;
      } else if (fourCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= threeCountTagWidth) {
        tagWidth = threeCountTagWidth;
      } else {
        tagWidth = fourCountTagWidth;
      }
    } else {
      tagWidth = (BrnRangeSelectionGroupWidget.screenWidth -
              40 -
              12 * (widget.rowCount! - 1)) ~/
          widget.rowCount!;
    }

    var tagContainer = tagFilterList.isNotEmpty
        ? Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: BrnSelectionRangeTagWidget(
                tagWidth: tagWidth,
                tagFilterList: tagFilterList,
                initFocusedIndex: _getInitFocusedIndex(subFilterList),
                themeData: widget.themeData,
                onSelect: (index, isSelected) {
                  setState(() {
                    _setFirstIndex(_tabController.index);
                    _setSecondIndex(index);
                    _clearNotTagItem(totalLevel == 1
                        ? _firstList
                        : _firstList[_tabController.index].children);
                    _clearEditRangeText();
                  });
                }),
          )
        : Container();

    Widget? content;
    for (BrnSelectionEntity item in subFilterList) {
      if (item.filterType == BrnSelectionFilterType.range) {
        content = BrnSelectionRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onFocusChanged: (bool focus) {
              item.isSelected = focus;
              if (focus) {
                setState(() {
                  _clearTagSelectStatus(subFilterList);
                });
              }
            });
        break;
      } else if (item.filterType == BrnSelectionFilterType.dateRange) {
        content = BrnSelectionDateRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onTapped: () {
              setState(() {
                _clearTagSelectStatus(subFilterList);
              });
            });
        break;
      } else if (item.filterType == BrnSelectionFilterType.date) {
        DateTime? initialStartDate =
            DateTimeFormatter.convertIntValueToDateTime(item.value);
        DateTime? initialEndDate =
            DateTimeFormatter.convertIntValueToDateTime(item.value);
        content = BrnCalendarView.single(
          key: GlobalKey(),
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          initDisplayDate: initialEndDate,
          dateChange: (DateTime date) {
            item.value = date.millisecondsSinceEpoch.toString();
            item.isSelected = true;
            setState(() {
              _clearTagSelectStatus(subFilterList);
            });
          },
        );
      } else if (item.filterType == BrnSelectionFilterType.dateRangeCalendar) {
        DateTime? initialStartDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(
                item.customMap!['min']);
        DateTime? initialEndDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(
                item.customMap!['max']);
        content = BrnCalendarView.range(
          key: GlobalKey(),
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          rangeDateChange: (DateTimeRange range) {
            item.customMap = {};
            item.customMap = {
              'min': range.start.millisecondsSinceEpoch.toString(),
              'max': range.end.millisecondsSinceEpoch.toString()
            };
            item.isSelected = true;
            setState(() {
              _clearTagSelectStatus(subFilterList);
            });
          },
        );
      }
    }
    var widgets = <Widget>[tagContainer];
    if (content != null) {
      widgets.add(content);
    }
    return widgets;
  }

  Widget _bottomWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, 11, 20, 11),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 24,
                    child:
                        BrunoTools.getAssetImage(BrnAsset.iconSelectionReset),
                  ),
                  Text(
                    '??????',
                    style: widget.themeData.resetTextStyle.generateTextStyle(),
                  )
                ],
              ),
            ),
            onTap: _clearAllSelectedItems,
          ),
          Expanded(
            child: BrnBigMainButton(
              title: '??????',
              onTap: () {
                _confirmButtonClickEvent();
              },
            ),
          )
        ],
      ),
    );
  }

  //pragma mark -- event responder

  /// ???????????????????????????????????????
  ///
  void _confirmButtonClickEvent() {
    _isConfirmClick = true;

    if (totalLevel == 2) {
      List<BrnSelectionEntity> subFilterList =
          widget.entity.children[_tabController.index].children;
      List<BrnSelectionEntity> selectItems =
          subFilterList.where((f) => f.isSelected).toList();
      if (selectItems.isNotEmpty) {
        _firstList[_tabController.index].isSelected = true;
      } else {
        _firstList[_tabController.index].isSelected = false;
      }
    }

    // ??????Range???????????????
    BrnSelectionEntity? rangeEntity = _getSelectRangeItem(totalLevel == 1
        ? _firstList
        : _firstList[_tabController.index].children);
    if (rangeEntity != null) {
      if (rangeEntity.customMap != null &&
          (!BrunoTools.isEmpty(rangeEntity.customMap!['min']) ||
              !BrunoTools.isEmpty(rangeEntity.customMap!['max']))) {
        if (!rangeEntity.isValidRange()) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (rangeEntity.filterType == BrnSelectionFilterType.range) {
            BrnToast.show('????????????????????????', context);
          } else if (rangeEntity.filterType ==
                  BrnSelectionFilterType.dateRange ||
              rangeEntity.filterType ==
                  BrnSelectionFilterType.dateRangeCalendar) {
            BrnToast.show('????????????????????????', context);
          }
          return;
        }
      } else {
        rangeEntity.isSelected = false;
      }
    }

    if (widget.onSelectionConfirm != null) {
      widget.onSelectionConfirm!(widget.entity, _firstIndex, _secondIndex, -1);
    }
  }

  void _clearAllSelectedItems() {
    _resetSelectionDatas(widget.entity);
    _clearNotTagItem(totalLevel == 1
        ? _firstList
        : _firstList[_tabController.index].children);
    _clearEditRangeText();
    setState(() {
      _configDefaultInitSelectIndex();
      _refreshDataSource();
    });
  }

  // ???????????????
  void _initData() {
    // ?????????????????????
    _originalSelectedItemsList = widget.entity.selectedList();
    for (BrnSelectionEntity entity in _originalSelectedItemsList) {
      entity.isSelected = true;
      if (entity.customMap != null) {
        entity.originalCustomMap = Map.from(entity.customMap!);
      }
    }
    // ???????????????????????? index ??? -1???????????????
    _configDefaultInitSelectIndex();
    // ???????????????????????????????????????index
    _configDefaultSelectedData();
    // ?????????????????????index???????????????
    _refreshDataSource();
  }

  // ?????????????????????????????????????????????index
  void _configDefaultInitSelectIndex() {
    _firstIndex = _secondIndex = -1;
  }

  void _setFirstIndex(int firstIndex) {
    _firstIndex = firstIndex;
    _secondIndex = -1;
    if (widget.entity.children.length > _firstIndex) {
      List<BrnSelectionEntity> seconds =
          widget.entity.children[_firstIndex].children;
      if (seconds.isNotEmpty) {
        for (BrnSelectionEntity entity in seconds) {
          if (entity.isSelected) {
            _setSecondIndex(seconds.indexOf(entity));
            break;
          }
        }
      }
    }
    setState(() {
      _refreshDataSource();
    });
  }

  void _setSecondIndex(int secondIndex) {
    _secondIndex = secondIndex;
    setState(() {
      _refreshDataSource();
    });
  }

  // ??????3???ListView????????????
  void _refreshDataSource() {
    _firstList = widget.entity.children;
    if (_firstIndex >= 0 && _firstList.length > _firstIndex) {
      _secondList = _firstList[_firstIndex].children;
    } else {
      _secondList = [];
    }
  }

  void _configDefaultSelectedData() {
    _firstList = widget.entity.children;
    //??????????????????item?????????????????????
    if (_firstList.isEmpty) {
      _secondIndex = -1;
      _secondList = [];
      return;
    }
    for (BrnSelectionEntity entity in _firstList) {
      if (entity.isSelected) {
        _firstIndex = _firstList.indexOf(entity);
        break;
      }
    }

    if (_firstIndex >= 0 && _firstIndex < _firstList.length) {
      _secondList = _firstList[_firstIndex].children;
      if (_secondList.isNotEmpty) {
        for (BrnSelectionEntity entity in _secondList) {
          if (entity.isSelected) {
            _secondIndex = _secondList.indexOf(entity);
            break;
          }
        }
      }
    }
  }

  //??????????????????????????????
  void _resetSelectionDatas(BrnSelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = Map();
    for (BrnSelectionEntity subEntity in entity.children) {
      _resetSelectionDatas(subEntity);
    }
  }

  void _clearNotTagItem(List<BrnSelectionEntity> subFilterList) {
    subFilterList
        .where((f) =>
            f.filterType == BrnSelectionFilterType.range ||
            f.filterType == BrnSelectionFilterType.date ||
            f.filterType == BrnSelectionFilterType.dateRange ||
            f.filterType == BrnSelectionFilterType.dateRangeCalendar)
        .forEach((f) {
      f.isSelected = false;
      f.customMap = Map();
      f.value = null;
    });
  }

  void _clearEditRangeText() {
    _minTextEditingController.text = "";
    _maxTextEditingController.text = "";
    EventBus.instance.fire(ClearSelectionFocusEvent());
  }

  void _clearTagSelectStatus(List<BrnSelectionEntity> subFilterList) {
    subFilterList
        .where((f) => f.filterType != BrnSelectionFilterType.range)
        .where((f) => f.filterType != BrnSelectionFilterType.date)
        .where((f) => f.filterType != BrnSelectionFilterType.dateRange)
        .where((f) => f.filterType != BrnSelectionFilterType.dateRangeCalendar)
        .forEach((f) {
      f.isSelected = false;
      f.customMap = Map();
    });
  }

  /// ???????????? Range ????????????value ????????? DateRange???DateRangeCalendar ???????????????????????????????????????????????????????????????????????????????????????
  BrnSelectionEntity? _getSelectRangeItem(List<BrnSelectionEntity> filterList) {
    List<BrnSelectionEntity> ranges = filterList
        .where((f) =>
            (f.filterType == BrnSelectionFilterType.range ||
                f.filterType == BrnSelectionFilterType.dateRange ||
                f.filterType == BrnSelectionFilterType.dateRangeCalendar) &&
            f.isSelected)
        .toList();

    if (ranges.isNotEmpty) {
      return ranges[0];
    }
    return null;
  }

  void _backgroundTap() {
    _resetSelectStatus();
    if (widget.bgClickFunction != null) {
      widget.bgClickFunction!();
    }
  }

  void _resetSelectStatus() {
    _clearAllSelectedItems();
    _resetCustomMapData();
  }

  ///????????????
  void _resetCustomMapData() {
    for (BrnSelectionEntity commonEntity in _originalSelectedItemsList) {
      commonEntity.isSelected = true;
      commonEntity.customMap = Map.from(commonEntity.originalCustomMap);
    }
  }

  /// ???????????????????????????????????????????????????????????????????????????????????????????????? Tag???
  int _getInitFocusedIndex(List<BrnSelectionEntity> subFilterList) {
    bool isCustomInputSelected = false;
    for (BrnSelectionEntity entity in subFilterList) {
      if (BrnSelectionFilterType.range == entity.filterType ||
          BrnSelectionFilterType.dateRange == entity.filterType ||
          BrnSelectionFilterType.dateRangeCalendar == entity.filterType) {
        isCustomInputSelected = entity.isSelected;
        break;
      }
    }

    var selectedItem = subFilterList
        .where((f) =>
            f.filterType != BrnSelectionFilterType.range &&
            f.filterType != BrnSelectionFilterType.dateRange &&
            f.filterType != BrnSelectionFilterType.dateRangeCalendar &&
            f.isSelected)
        .toList();
    if (!isCustomInputSelected && BrunoTools.isEmpty(selectedItem)) {
      for (BrnSelectionEntity item in subFilterList) {
        if (item.isUnLimit()) {
          return subFilterList.indexOf(item);
        }
      }
    }

    return -1;
  }

  bool _hasCalendarItem(BrnSelectionEntity entity) {
    bool hasCalendarItem = false;
    hasCalendarItem = entity.children
            .where((_) =>
                _.filterType == BrnSelectionFilterType.date ||
                _.filterType == BrnSelectionFilterType.dateRangeCalendar)
            .toList().isNotEmpty;

    /// ??????????????????
    if (!hasCalendarItem) {
      for (BrnSelectionEntity subItem in entity.children) {
        int count = subItem.children
            .where((_) =>
                _.filterType == BrnSelectionFilterType.date ||
                _.filterType == BrnSelectionFilterType.dateRangeCalendar)
            .toList()
            .length;
        if (count > 0) {
          hasCalendarItem = true;
          break;
        }
      }
    }
    return hasCalendarItem;
  }
}
