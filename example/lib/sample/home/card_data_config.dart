import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:example/sample/components/actionsheet/actionsheet_entry_page.dart';
import 'package:example/sample/components/appraise/appraise_example.dart';
import 'package:example/sample/components/bottom_tabbar/bottom_tabbar_example.dart';
import 'package:example/sample/components/button/bottom_button_entry_page.dart';
import 'package:example/sample/components/button/button_entry_page.dart';
import 'package:example/sample/components/button/button_panel_entry_page.dart';
import 'package:example/sample/components/button/icon_button_example.dart';
import 'package:example/sample/components/calendar/calendarview_example.dart';
import 'package:example/sample/components/card/brn_shadow_example.dart';
import 'package:example/sample/components/card/bubble/bubble_entry_page.dart';
import 'package:example/sample/components/card/content/text_content_entry_page.dart';
import 'package:example/sample/components/card_title/title_example.dart';
import 'package:example/sample/components/charts/chart_entry_example.dart';
import 'package:example/sample/components/charts/doughnut_chart_example.dart';
import 'package:example/sample/components/charts/line/brn_broken_line_example.dart';
import 'package:example/sample/components/charts/line/db_data_node_model.dart';
import 'package:example/sample/components/charts/progress_bar_chart_example.dart';
import 'package:example/sample/components/charts/progress_chart_entry_page.dart';
import 'package:example/sample/components/dialog/dialog_entry_page.dart';
import 'package:example/sample/components/empty/abnormal_entry_page.dart';
import 'package:example/sample/components/form/all_item_style_example.dart';
import 'package:example/sample/components/gallery/gallery_example.dart';
import 'package:example/sample/components/guide/guide_entry_page.dart';
import 'package:example/sample/components/input/input_example.dart';
import 'package:example/sample/components/line/dashed_line_example.dart';
import 'package:example/sample/components/loading/loading_widget_example.dart';
import 'package:example/sample/components/navbar/appbar_entry_page.dart';
import 'package:example/sample/components/noticebar/brn_notice_bar_example.dart';
import 'package:example/sample/components/picker/picker_entry_page.dart';
import 'package:example/sample/components/popup/popwindow_example.dart';
import 'package:example/sample/components/rating/rating_example.dart';
import 'package:example/sample/components/scroll_anchor/scroll_actor_tab_example.dart';
import 'package:example/sample/components/selection/selection_entry_page.dart';
import 'package:example/sample/components/step/step_example.dart';
import 'package:example/sample/components/sugsearch/search_text_example.dart';
import 'package:example/sample/components/switch/brn_switch_example.dart';
import 'package:example/sample/components/switch/checkbox_example.dart';
import 'package:example/sample/components/switch/radio_example.dart';
import 'package:example/sample/components/tabbar/brn_tab_example.dart';
import 'package:example/sample/components/tag/tag_example.dart';
import 'package:example/sample/components/toast/toast_example.dart';
import 'package:example/sample/liyixin/builder_demo.dart';
import 'package:example/sample/liyixin/clip_demo.dart';
import 'package:example/sample/liyixin/constraint_demo.dart';
import 'package:example/sample/liyixin/container_demo.dart';
import 'package:example/sample/liyixin/dialog_qf_demo.dart';
import 'package:example/sample/liyixin/easy_refresh.dart';
import 'package:example/sample/liyixin/form_demo.dart';
import 'package:example/sample/liyixin/ios_refresh_demo.dart';
import 'package:example/sample/liyixin/nav_bar_tab_demo.dart';
import 'package:example/sample/liyixin/notification_demo.dart';
import 'package:example/sample/liyixin/offstage_visible_demo.dart';
import 'package:example/sample/liyixin/pageview_demo.dart';
import 'package:example/sample/liyixin/physics_demo.dart';
import 'package:example/sample/liyixin/provider/provider_demo.dart';
import 'package:example/sample/liyixin/refreshindicator_demo.dart';
import 'package:example/sample/liyixin/refreshindicator_scrollview_demo.dart';
import 'package:example/sample/liyixin/repeat_boundary_demo.dart';
import 'package:example/sample/liyixin/rich_text_demo.dart';
import 'package:example/sample/liyixin/set_state_counter_demo.dart';
import 'package:example/sample/liyixin/stack_demo.dart';
import 'package:example/sample/liyixin/stream_demo.dart';
import 'package:example/sample/liyixin/value_listenable_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../liyixin/nav_bar_tab_demo2.dart';

/// ????????????
class GroupInfo {
  /// ??????ID
  int? groupId;

  /// ?????????
  String groupName;

  /// ??????
  String desc;

  /// ????????????
  bool isExpand;

  /// ???????????????
  bool isSupportTheme;

  /// ???Widget
  List<GroupInfo>? children;

  /// ????????????????????????
  Function(BuildContext context)? navigatorPage;

  GroupInfo({this.groupId, this.groupName = "", this.desc = "", this.isExpand = false, this.navigatorPage, this.isSupportTheme = false, this.children});
}

/// ???????????????
class CardDataConfig {
  /// ??????
  static List<GroupInfo> getAllGroup() {
    List<GroupInfo> list = [];
    list.add(_getLiyixinGroup());
    list.add(_getChartGroup());
    list.add(_getDataInputGroup());
    list.add(_getOperateGroup());
    list.add(_getNavigatorGroup());
    list.add(_getButtonGroup());
    list.add(_getContentGroup());
    return list;
  }

  /// ????????????
  static GroupInfo _getChartGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "BrokenLine ????????? ",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          rootBundle.loadString('assets/brokenline_data.json').then((data) {
            var brokenData = <DBDataNodeModel>[]..addAll(((JsonDecoder().convert(data) as List?) ?? []).map((o) => DBDataNodeModel.fromJson(o)));
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return BrokenLineExample(brokenData);
              },
            ));
          });
        }));
    children.add(GroupInfo(
        groupName: "Radar ?????????",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RadarChartExamplePage();
            },
          ));
        }));

    children.add(GroupInfo(
        groupName: "Funnel ?????????",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return FunnelChartExamplePage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Doughnut ?????????",
        desc: "?????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DoughnutChartExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Progress ?????????",
        desc: "?????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProgressChartExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ProgressBar ?????????",
        desc: "?????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProgressBarChartExample();
            },
          ));
        }));
    return GroupInfo(groupName: "????????????", children: children);
  }

  /// ????????????
  static GroupInfo _getDataInputGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Form ?????????",
        desc: "???????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AllFormItemStyleExamplePage("?????????????????????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Picker ?????????",
        desc: "????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PickerEntryPage("Picker??????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Appraise ??????",
        desc: "???????????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AppraiseExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Input ???????????????",
        desc: "????????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnInputTextExample();
            },
          ));
        }));
    return GroupInfo(groupName: "????????????", children: children, isExpand: false);
  }

  /// ???????????????
  static GroupInfo _getOperateGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Dialog ??????",
        desc: "Dialog??????????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DialogEntryPage("Dialog????????????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ActionSheet ????????????",
        desc: "??????????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ActionSheetEntryPage("ActionSheet??????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Tips ??????",
        desc: "???????????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PopWindowExamplePage("Tips ????????????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Toast ??????",
        desc: "?????? Toast",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ToastExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Loading ?????????",
        desc: "??????loading",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return LoadingExample();
            },
          ));
        }));
    return GroupInfo(groupName: "????????????", children: children, isExpand: false);
  }

  /// ?????????
  static GroupInfo _getNavigatorGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Appbar ?????????",
        desc: "Appbar ?????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AppbarEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Search ??????",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SearchTextExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Tabs ??????",
        desc: "tab",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnTabExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "BottomTabBar ????????????",
        desc: "????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BottomTabbarExample();
          }));
        }));
    children.add(GroupInfo(
        groupName: "Selection ??????",
        desc: "?????????+????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SelectionEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "CitySelection ????????????",
        desc: "????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return _buildSingleSelectCityPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Anchor ??????",
        desc: "?????? Tab ????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ScrollActorTabExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Guide ??????",
        desc: "?????????&?????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return GuideEntryPage();
            },
          ));
        }));
    return GroupInfo(groupName: "??????", children: children);
  }

  /// ??????
  static GroupInfo _getButtonGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "NormalButton ????????????",
        desc: "????????????????????????????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ButtonEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "BottomButtonPanel ????????????",
        desc: "??????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BottomButtonEntryWidget();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ButtonPanel ????????????",
        desc: "????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ButtonPanelEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "IconButton ????????????",
        desc: "button???????????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnIconBtnExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Radio ????????????",
        desc: "????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RadioExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Checkbox ????????????",
        desc: "????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return CheckboxExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "SwitchButton ????????????",
        desc: "Switch ??????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnSwitchButtonExample();
            },
          ));
        }));
    return GroupInfo(groupName: "??????", children: children, isExpand: false);
  }

  /// ??????
  static GroupInfo _getContentGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "Tag ??????",
        desc: "??????????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TagExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RatingBar ??????",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RatingExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "DashedLine ???????????????",
        desc: "???????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DashedLineExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "ShadowCard ????????????",
        desc: "BrnShadowCard",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnShadowExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Title ??????",
        desc: "??????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TitleExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "AbnormalCard ????????????",
        desc: "????????????????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AbnormalStatesEntryPage("??????????????????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Bubble ?????? ",
        desc: "????????????&???????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BubbleEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "StepBar ?????????",
        desc: "??????&???????????????",
        isSupportTheme: true,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return StepExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Notification ??????",
        desc: "????????????????????????????????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BrnNoticeBarExample();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Text ????????????",
        desc: "?????????????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return TextContentEntryPage();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Calendar??????",
        desc: "????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return CalendarViewExample("????????????");
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Gallery ??????",
        desc: "????????????&????????????",
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return GalleryExample();
            },
          ));
        }));
    return GroupInfo(groupName: "??????", children: children);
  }

  static GroupInfo _getLiyixinGroup() {
    List<GroupInfo> children = [];
    children.add(GroupInfo(
        groupName: "ValueListenable",
        desc: "????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ValueListenableDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "setState????????????",
        desc: "????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SetStateCounterDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Provider????????????",
        desc: "Provider???ChangeNotifer???Consumer",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProviderDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RepeatBoundary",
        desc: "????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RepeatBoundaryDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "NavBarTab",
        desc: "???tab???actionbar",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return NavBarTabDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "????????????tab",
        desc: "????????????TabBar",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return NavBarTabDemo2();
            },
          ));
        }));

    children.add(GroupInfo(
        groupName: "Clip",
        desc: "Clip????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ClipDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Stream",
        desc: "Stream??????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return StreamDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "?????????",
        desc: "?????????????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return DialogQfDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Form",
        desc: "Form ???TextFiledForm???",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return FormDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Stack",
        desc: "stack???Positioned???????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return StackDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Notification",
        desc: "??????Flutter????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return NotificationDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "OffStage & Visible",
        desc: "Flutter??????????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return OffStageAndVisibleDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Builder",
        desc: "?????????????????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BuilderDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RichText",
        desc: "?????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RichTextDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "EasyRefresh",
        desc: "????????????&????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return EasyRefreshDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RefreshIndicator",
        desc: "???????????????????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RefreshIndicatorDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "RefreshIndicator + ScrollView",
        desc: "??????????????????????????? + ScrollView",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return RefreshIndicatorWithScrollViewDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "CupertinoSliverRefreshControl",
        desc: "iOS????????????????????????????????????????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return IOSRefreshDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Physics",
        desc: "flutter????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PhysicsDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "[??????]????????????",
        desc: "??????Flutter???????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ConstraintDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "PageView",
        desc: "",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return PageViewDemo();
            },
          ));
        }));
    children.add(GroupInfo(
        groupName: "Container",
        desc: "??????Container???????????? & ???????????????",
        isSupportTheme: false,
        navigatorPage: (BuildContext context) {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ContainerDemo();
            },
          ));
        }));
    return GroupInfo(groupName: "LiYiXin", children: children, isExpand: true);
  }

  /// ????????????
  static Widget _buildSingleSelectCityPage() {
    List<BrnSelectCityModel> hotCityList = [];
    hotCityList.addAll([
      BrnSelectCityModel(name: "?????????"),
      BrnSelectCityModel(name: "?????????"),
      BrnSelectCityModel(name: "?????????"),
      BrnSelectCityModel(name: "?????????"),
      BrnSelectCityModel(name: "?????????"),
      BrnSelectCityModel(name: "?????????"),
    ]);
    return BrnSingleSelectCityPage(
      appBarTitle: '????????????',
      hotCityTitle: '?????????????????????',
      hotCityList: hotCityList,
    );
  }
}
