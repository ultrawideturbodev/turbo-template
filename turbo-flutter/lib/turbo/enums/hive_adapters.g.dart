// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class NavigationTabAdapter extends TypeAdapter<NavigationTab> {
  @override
  final int typeId = 1;

  @override
  NavigationTab read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NavigationTab.home;
      case 1:
        return NavigationTab.placeholder;
      case 2:
        return NavigationTab.defaultValue;
      default:
        return NavigationTab.home;
    }
  }

  @override
  void write(BinaryWriter writer, NavigationTab obj) {
    switch (obj) {
      case NavigationTab.home:
        writer.writeByte(0);
      case NavigationTab.placeholder:
        writer.writeByte(1);
      case NavigationTab.defaultValue:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationTabAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SupportedLanguageAdapter extends TypeAdapter<SupportedLanguage> {
  @override
  final int typeId = 2;

  @override
  SupportedLanguage read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SupportedLanguage.nl;
      case 1:
        return SupportedLanguage.en;
      case 2:
        return SupportedLanguage.defaultValue;
      default:
        return SupportedLanguage.nl;
    }
  }

  @override
  void write(BinaryWriter writer, SupportedLanguage obj) {
    switch (obj) {
      case SupportedLanguage.nl:
        writer.writeByte(0);
      case SupportedLanguage.en:
        writer.writeByte(1);
      case SupportedLanguage.defaultValue:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportedLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TurboThemeModeAdapter extends TypeAdapter<TurboThemeMode> {
  @override
  final int typeId = 3;

  @override
  TurboThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TurboThemeMode.dark;
      case 1:
        return TurboThemeMode.light;
      case 2:
        return TurboThemeMode.defaultValue;
      default:
        return TurboThemeMode.dark;
    }
  }

  @override
  void write(BinaryWriter writer, TurboThemeMode obj) {
    switch (obj) {
      case TurboThemeMode.dark:
        writer.writeByte(0);
      case TurboThemeMode.light:
        writer.writeByte(1);
      case TurboThemeMode.defaultValue:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TurboThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthStepAdapter extends TypeAdapter<AuthStep> {
  @override
  final int typeId = 4;

  @override
  AuthStep read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AuthStep.createUserDoc;
      case 1:
        return AuthStep.acceptPrivacy;
      case 2:
        return AuthStep.createSettingsDoc;
      case 3:
        return AuthStep.createUsernameDoc;
      case 4:
        return AuthStep.createProfileDoc;
      case 5:
        return AuthStep.verifyEmail;
      case 6:
        return AuthStep.first;
      default:
        return AuthStep.createUserDoc;
    }
  }

  @override
  void write(BinaryWriter writer, AuthStep obj) {
    switch (obj) {
      case AuthStep.createUserDoc:
        writer.writeByte(0);
      case AuthStep.acceptPrivacy:
        writer.writeByte(1);
      case AuthStep.createSettingsDoc:
        writer.writeByte(2);
      case AuthStep.createUsernameDoc:
        writer.writeByte(3);
      case AuthStep.createProfileDoc:
        writer.writeByte(4);
      case AuthStep.verifyEmail:
        writer.writeByte(5);
      case AuthStep.first:
        writer.writeByte(6);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmojiAdapter extends TypeAdapter<Emoji> {
  @override
  final int typeId = 5;

  @override
  Emoji read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Emoji.ghost;
      case 1:
        return Emoji.fire;
      case 2:
        return Emoji.shaka;
      case 3:
        return Emoji.heartOnFire;
      case 4:
        return Emoji.explosion;
      case 5:
        return Emoji.flexedBiceps;
      case 6:
        return Emoji.thumbsUp;
      case 7:
        return Emoji.okHand;
      case 8:
        return Emoji.clappingHands;
      case 9:
        return Emoji.raisingHands;
      case 10:
        return Emoji.eyes;
      case 11:
        return Emoji.link;
      case 12:
        return Emoji.calendar;
      case 13:
        return Emoji.magnifyingGlass;
      case 14:
        return Emoji.prostheticLeg;
      case 15:
        return Emoji.camera;
      case 16:
        return Emoji.sparkles;
      case 17:
        return Emoji.fireDuplicate;
      case 18:
        return Emoji.gift;
      case 19:
        return Emoji.speakingHead;
      case 20:
        return Emoji.magicWand;
      case 21:
        return Emoji.unicorn;
      case 22:
        return Emoji.runningShoe;
      case 23:
        return Emoji.barbell;
      case 24:
        return Emoji.stopwatch;
      case 25:
        return Emoji.danger;
      case 26:
        return Emoji.checkMark;
      case 27:
        return Emoji.trophy;
      case 28:
        return Emoji.mapPin;
      case 29:
        return Emoji.groupOfPeople;
      case 30:
        return Emoji.chatBubble;
      case 31:
        return Emoji.mobilePhone;
      case 32:
        return Emoji.ticket;
      case 33:
        return Emoji.nutrition;
      case 34:
        return Emoji.pencil;
      case 35:
        return Emoji.blackNib;
      case 36:
        return Emoji.fountainPen;
      case 37:
        return Emoji.pen;
      case 38:
        return Emoji.paintbrush;
      case 39:
        return Emoji.crayon;
      case 40:
        return Emoji.note;
      case 41:
        return Emoji.clipboard;
      case 42:
        return Emoji.fileFolder;
      case 43:
        return Emoji.openFileFolder;
      case 44:
        return Emoji.barChart;
      case 45:
        return Emoji.chartIncreasing;
      case 46:
        return Emoji.chartDecreasing;
      case 47:
        return Emoji.paperclip;
      case 48:
        return Emoji.pageWithCurl;
      case 49:
        return Emoji.pageFacingUp;
      case 50:
        return Emoji.wastebasket;
      case 51:
        return Emoji.straightRuler;
      case 52:
        return Emoji.triangularRuler;
      case 53:
        return Emoji.pushpin;
      case 54:
        return Emoji.roundPushpin;
      case 55:
        return Emoji.ledger;
      case 56:
        return Emoji.orangeBook;
      case 57:
        return Emoji.greenBook;
      case 58:
        return Emoji.blueBook;
      case 59:
        return Emoji.notebook;
      case 60:
        return Emoji.notebookWithDecorativeCover;
      case 61:
        return Emoji.newsPaper;
      case 62:
        return Emoji.house;
      case 63:
        return Emoji.prize;
      case 64:
        return Emoji.contacts;
      case 65:
        return Emoji.wavingHand;
      case 66:
        return Emoji.email;
      case 67:
        return Emoji.shakingHands;
      case 68:
        return Emoji.whiteHeart;
      case 69:
        return Emoji.heart;
      case 70:
        return Emoji.goal;
      case 71:
        return Emoji.cloud;
      case 72:
        return Emoji.calculator;
      case 73:
        return Emoji.idea;
      case 74:
        return Emoji.floppy;
      case 75:
        return Emoji.cog;
      case 76:
        return Emoji.tomato;
      case 77:
        return Emoji.account;
      case 78:
        return Emoji.payments;
      case 79:
        return Emoji.courses;
      case 80:
        return Emoji.roadmap;
      case 81:
        return Emoji.theFeatures;
      case 82:
        return Emoji.theWorkshop;
      case 83:
        return Emoji.theArchive;
      case 84:
        return Emoji.theMailbox;
      case 85:
        return Emoji.lastNote;
      case 86:
        return Emoji.quickActions;
      case 87:
        return Emoji.cross;
      case 88:
        return Emoji.world;
      case 89:
        return Emoji.warning;
      case 90:
        return Emoji.tasks;
      case 91:
        return Emoji.dove;
      case 92:
        return Emoji.filter;
      case 93:
        return Emoji.time;
      case 94:
        return Emoji.magic;
      case 95:
        return Emoji.paradise;
      case 96:
        return Emoji.outOfTime;
      case 97:
        return Emoji.allTodos;
      case 98:
        return Emoji.add;
      case 99:
        return Emoji.logs;
      case 100:
        return Emoji.candle;
      case 101:
        return Emoji.ice;
      case 102:
        return Emoji.snow;
      case 103:
        return Emoji.robot;
      case 104:
        return Emoji.snowMan;
      case 105:
        return Emoji.wolf;
      case 106:
        return Emoji.snooze;
      case 107:
        return Emoji.profile;
      case 108:
        return Emoji.party;
      case 109:
        return Emoji.wonder;
      case 110:
        return Emoji.hug;
      case 111:
        return Emoji.openBook;
      case 112:
        return Emoji.present;
      case 113:
        return Emoji.happyBlush;
      case 114:
        return Emoji.sweat;
      case 115:
        return Emoji.finishLine;
      case 116:
        return Emoji.poker;
      case 117:
        return Emoji.collections;
      case 118:
        return Emoji.clown;
      case 119:
        return Emoji.snoozeAll;
      case 120:
        return Emoji.wood;
      case 121:
        return Emoji.tag;
      case 122:
        return Emoji.pin;
      case 123:
        return Emoji.deadline;
      case 124:
        return Emoji.oldestTasks;
      case 125:
        return Emoji.start;
      case 126:
        return Emoji.end;
      case 127:
        return Emoji.duration;
      case 128:
        return Emoji.tools;
      case 129:
        return Emoji.star;
      case 130:
        return Emoji.rocket;
      case 131:
        return Emoji.lightBulb;
      case 132:
        return Emoji.clock;
      case 133:
        return Emoji.bell;
      case 134:
        return Emoji.lock;
      case 135:
        return Emoji.key;
      case 136:
        return Emoji.hammer;
      case 137:
        return Emoji.wrench;
      case 138:
        return Emoji.gear;
      case 139:
        return Emoji.flag;
      case 140:
        return Emoji.target;
      case 141:
        return Emoji.medal;
      case 142:
        return Emoji.crown;
      case 143:
        return Emoji.money;
      case 144:
        return Emoji.creditCard;
      case 145:
        return Emoji.shoppingCart;
      case 146:
        return Emoji.package;
      case 147:
        return Emoji.airplane;
      case 148:
        return Emoji.car;
      case 149:
        return Emoji.bus;
      case 150:
        return Emoji.train;
      case 151:
        return Emoji.bicycle;
      case 152:
        return Emoji.umbrella;
      case 153:
        return Emoji.sun;
      case 154:
        return Emoji.moon;
      case 155:
        return Emoji.rainbow;
      case 156:
        return Emoji.earth;
      case 157:
        return Emoji.mountain;
      case 158:
        return Emoji.tree;
      case 159:
        return Emoji.flower;
      case 160:
        return Emoji.leaf;
      case 161:
        return Emoji.seedling;
      case 162:
        return Emoji.recycle;
      case 163:
        return Emoji.battery;
      case 164:
        return Emoji.plug;
      case 165:
        return Emoji.computer;
      case 166:
        return Emoji.smartphone;
      case 167:
        return Emoji.tv;
      case 168:
        return Emoji.videoCamera;
      case 169:
        return Emoji.microphone;
      case 170:
        return Emoji.headphones;
      case 171:
        return Emoji.speaker;
      case 172:
        return Emoji.megaphone;
      case 173:
        return Emoji.envelope;
      case 174:
        return Emoji.inbox;
      case 175:
        return Emoji.outbox;
      case 176:
        return Emoji.folder;
      case 177:
        return Emoji.trashCan;
      case 178:
        return Emoji.graph;
      case 179:
        return Emoji.chart;
      case 180:
        return Emoji.bug;
      case 181:
        return Emoji.testTube;
      case 182:
        return Emoji.label;
      case 183:
        return Emoji.bookmark;
      case 184:
        return Emoji.thoughtBubble;
      case 185:
        return Emoji.brain;
      case 186:
        return Emoji.document;
      case 187:
        return Emoji.bookmarkTabs;
      default:
        return Emoji.ghost;
    }
  }

  @override
  void write(BinaryWriter writer, Emoji obj) {
    switch (obj) {
      case Emoji.ghost:
        writer.writeByte(0);
      case Emoji.fire:
        writer.writeByte(1);
      case Emoji.shaka:
        writer.writeByte(2);
      case Emoji.heartOnFire:
        writer.writeByte(3);
      case Emoji.explosion:
        writer.writeByte(4);
      case Emoji.flexedBiceps:
        writer.writeByte(5);
      case Emoji.thumbsUp:
        writer.writeByte(6);
      case Emoji.okHand:
        writer.writeByte(7);
      case Emoji.clappingHands:
        writer.writeByte(8);
      case Emoji.raisingHands:
        writer.writeByte(9);
      case Emoji.eyes:
        writer.writeByte(10);
      case Emoji.link:
        writer.writeByte(11);
      case Emoji.calendar:
        writer.writeByte(12);
      case Emoji.magnifyingGlass:
        writer.writeByte(13);
      case Emoji.prostheticLeg:
        writer.writeByte(14);
      case Emoji.camera:
        writer.writeByte(15);
      case Emoji.sparkles:
        writer.writeByte(16);
      case Emoji.fireDuplicate:
        writer.writeByte(17);
      case Emoji.gift:
        writer.writeByte(18);
      case Emoji.speakingHead:
        writer.writeByte(19);
      case Emoji.magicWand:
        writer.writeByte(20);
      case Emoji.unicorn:
        writer.writeByte(21);
      case Emoji.runningShoe:
        writer.writeByte(22);
      case Emoji.barbell:
        writer.writeByte(23);
      case Emoji.stopwatch:
        writer.writeByte(24);
      case Emoji.danger:
        writer.writeByte(25);
      case Emoji.checkMark:
        writer.writeByte(26);
      case Emoji.trophy:
        writer.writeByte(27);
      case Emoji.mapPin:
        writer.writeByte(28);
      case Emoji.groupOfPeople:
        writer.writeByte(29);
      case Emoji.chatBubble:
        writer.writeByte(30);
      case Emoji.mobilePhone:
        writer.writeByte(31);
      case Emoji.ticket:
        writer.writeByte(32);
      case Emoji.nutrition:
        writer.writeByte(33);
      case Emoji.pencil:
        writer.writeByte(34);
      case Emoji.blackNib:
        writer.writeByte(35);
      case Emoji.fountainPen:
        writer.writeByte(36);
      case Emoji.pen:
        writer.writeByte(37);
      case Emoji.paintbrush:
        writer.writeByte(38);
      case Emoji.crayon:
        writer.writeByte(39);
      case Emoji.note:
        writer.writeByte(40);
      case Emoji.clipboard:
        writer.writeByte(41);
      case Emoji.fileFolder:
        writer.writeByte(42);
      case Emoji.openFileFolder:
        writer.writeByte(43);
      case Emoji.barChart:
        writer.writeByte(44);
      case Emoji.chartIncreasing:
        writer.writeByte(45);
      case Emoji.chartDecreasing:
        writer.writeByte(46);
      case Emoji.paperclip:
        writer.writeByte(47);
      case Emoji.pageWithCurl:
        writer.writeByte(48);
      case Emoji.pageFacingUp:
        writer.writeByte(49);
      case Emoji.wastebasket:
        writer.writeByte(50);
      case Emoji.straightRuler:
        writer.writeByte(51);
      case Emoji.triangularRuler:
        writer.writeByte(52);
      case Emoji.pushpin:
        writer.writeByte(53);
      case Emoji.roundPushpin:
        writer.writeByte(54);
      case Emoji.ledger:
        writer.writeByte(55);
      case Emoji.orangeBook:
        writer.writeByte(56);
      case Emoji.greenBook:
        writer.writeByte(57);
      case Emoji.blueBook:
        writer.writeByte(58);
      case Emoji.notebook:
        writer.writeByte(59);
      case Emoji.notebookWithDecorativeCover:
        writer.writeByte(60);
      case Emoji.newsPaper:
        writer.writeByte(61);
      case Emoji.house:
        writer.writeByte(62);
      case Emoji.prize:
        writer.writeByte(63);
      case Emoji.contacts:
        writer.writeByte(64);
      case Emoji.wavingHand:
        writer.writeByte(65);
      case Emoji.email:
        writer.writeByte(66);
      case Emoji.shakingHands:
        writer.writeByte(67);
      case Emoji.whiteHeart:
        writer.writeByte(68);
      case Emoji.heart:
        writer.writeByte(69);
      case Emoji.goal:
        writer.writeByte(70);
      case Emoji.cloud:
        writer.writeByte(71);
      case Emoji.calculator:
        writer.writeByte(72);
      case Emoji.idea:
        writer.writeByte(73);
      case Emoji.floppy:
        writer.writeByte(74);
      case Emoji.cog:
        writer.writeByte(75);
      case Emoji.tomato:
        writer.writeByte(76);
      case Emoji.account:
        writer.writeByte(77);
      case Emoji.payments:
        writer.writeByte(78);
      case Emoji.courses:
        writer.writeByte(79);
      case Emoji.roadmap:
        writer.writeByte(80);
      case Emoji.theFeatures:
        writer.writeByte(81);
      case Emoji.theWorkshop:
        writer.writeByte(82);
      case Emoji.theArchive:
        writer.writeByte(83);
      case Emoji.theMailbox:
        writer.writeByte(84);
      case Emoji.lastNote:
        writer.writeByte(85);
      case Emoji.quickActions:
        writer.writeByte(86);
      case Emoji.cross:
        writer.writeByte(87);
      case Emoji.world:
        writer.writeByte(88);
      case Emoji.warning:
        writer.writeByte(89);
      case Emoji.tasks:
        writer.writeByte(90);
      case Emoji.dove:
        writer.writeByte(91);
      case Emoji.filter:
        writer.writeByte(92);
      case Emoji.time:
        writer.writeByte(93);
      case Emoji.magic:
        writer.writeByte(94);
      case Emoji.paradise:
        writer.writeByte(95);
      case Emoji.outOfTime:
        writer.writeByte(96);
      case Emoji.allTodos:
        writer.writeByte(97);
      case Emoji.add:
        writer.writeByte(98);
      case Emoji.logs:
        writer.writeByte(99);
      case Emoji.candle:
        writer.writeByte(100);
      case Emoji.ice:
        writer.writeByte(101);
      case Emoji.snow:
        writer.writeByte(102);
      case Emoji.robot:
        writer.writeByte(103);
      case Emoji.snowMan:
        writer.writeByte(104);
      case Emoji.wolf:
        writer.writeByte(105);
      case Emoji.snooze:
        writer.writeByte(106);
      case Emoji.profile:
        writer.writeByte(107);
      case Emoji.party:
        writer.writeByte(108);
      case Emoji.wonder:
        writer.writeByte(109);
      case Emoji.hug:
        writer.writeByte(110);
      case Emoji.openBook:
        writer.writeByte(111);
      case Emoji.present:
        writer.writeByte(112);
      case Emoji.happyBlush:
        writer.writeByte(113);
      case Emoji.sweat:
        writer.writeByte(114);
      case Emoji.finishLine:
        writer.writeByte(115);
      case Emoji.poker:
        writer.writeByte(116);
      case Emoji.collections:
        writer.writeByte(117);
      case Emoji.clown:
        writer.writeByte(118);
      case Emoji.snoozeAll:
        writer.writeByte(119);
      case Emoji.wood:
        writer.writeByte(120);
      case Emoji.tag:
        writer.writeByte(121);
      case Emoji.pin:
        writer.writeByte(122);
      case Emoji.deadline:
        writer.writeByte(123);
      case Emoji.oldestTasks:
        writer.writeByte(124);
      case Emoji.start:
        writer.writeByte(125);
      case Emoji.end:
        writer.writeByte(126);
      case Emoji.duration:
        writer.writeByte(127);
      case Emoji.tools:
        writer.writeByte(128);
      case Emoji.star:
        writer.writeByte(129);
      case Emoji.rocket:
        writer.writeByte(130);
      case Emoji.lightBulb:
        writer.writeByte(131);
      case Emoji.clock:
        writer.writeByte(132);
      case Emoji.bell:
        writer.writeByte(133);
      case Emoji.lock:
        writer.writeByte(134);
      case Emoji.key:
        writer.writeByte(135);
      case Emoji.hammer:
        writer.writeByte(136);
      case Emoji.wrench:
        writer.writeByte(137);
      case Emoji.gear:
        writer.writeByte(138);
      case Emoji.flag:
        writer.writeByte(139);
      case Emoji.target:
        writer.writeByte(140);
      case Emoji.medal:
        writer.writeByte(141);
      case Emoji.crown:
        writer.writeByte(142);
      case Emoji.money:
        writer.writeByte(143);
      case Emoji.creditCard:
        writer.writeByte(144);
      case Emoji.shoppingCart:
        writer.writeByte(145);
      case Emoji.package:
        writer.writeByte(146);
      case Emoji.airplane:
        writer.writeByte(147);
      case Emoji.car:
        writer.writeByte(148);
      case Emoji.bus:
        writer.writeByte(149);
      case Emoji.train:
        writer.writeByte(150);
      case Emoji.bicycle:
        writer.writeByte(151);
      case Emoji.umbrella:
        writer.writeByte(152);
      case Emoji.sun:
        writer.writeByte(153);
      case Emoji.moon:
        writer.writeByte(154);
      case Emoji.rainbow:
        writer.writeByte(155);
      case Emoji.earth:
        writer.writeByte(156);
      case Emoji.mountain:
        writer.writeByte(157);
      case Emoji.tree:
        writer.writeByte(158);
      case Emoji.flower:
        writer.writeByte(159);
      case Emoji.leaf:
        writer.writeByte(160);
      case Emoji.seedling:
        writer.writeByte(161);
      case Emoji.recycle:
        writer.writeByte(162);
      case Emoji.battery:
        writer.writeByte(163);
      case Emoji.plug:
        writer.writeByte(164);
      case Emoji.computer:
        writer.writeByte(165);
      case Emoji.smartphone:
        writer.writeByte(166);
      case Emoji.tv:
        writer.writeByte(167);
      case Emoji.videoCamera:
        writer.writeByte(168);
      case Emoji.microphone:
        writer.writeByte(169);
      case Emoji.headphones:
        writer.writeByte(170);
      case Emoji.speaker:
        writer.writeByte(171);
      case Emoji.megaphone:
        writer.writeByte(172);
      case Emoji.envelope:
        writer.writeByte(173);
      case Emoji.inbox:
        writer.writeByte(174);
      case Emoji.outbox:
        writer.writeByte(175);
      case Emoji.folder:
        writer.writeByte(176);
      case Emoji.trashCan:
        writer.writeByte(177);
      case Emoji.graph:
        writer.writeByte(178);
      case Emoji.chart:
        writer.writeByte(179);
      case Emoji.bug:
        writer.writeByte(180);
      case Emoji.testTube:
        writer.writeByte(181);
      case Emoji.label:
        writer.writeByte(182);
      case Emoji.bookmark:
        writer.writeByte(183);
      case Emoji.thoughtBubble:
        writer.writeByte(184);
      case Emoji.brain:
        writer.writeByte(185);
      case Emoji.document:
        writer.writeByte(186);
      case Emoji.bookmarkTabs:
        writer.writeByte(187);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmojiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DateFormatAdapter extends TypeAdapter<DateFormat> {
  @override
  final int typeId = 6;

  @override
  DateFormat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DateFormat.MMDDYYYY;
      case 1:
        return DateFormat.DDMYYYY;
      case 2:
        return DateFormat.YYYYMMDD;
      case 3:
        return DateFormat.DDMMMYYYY;
      case 4:
        return DateFormat.DDMMYYYY;
      case 5:
        return DateFormat.defaultValue;
      default:
        return DateFormat.MMDDYYYY;
    }
  }

  @override
  void write(BinaryWriter writer, DateFormat obj) {
    switch (obj) {
      case DateFormat.MMDDYYYY:
        writer.writeByte(0);
      case DateFormat.DDMYYYY:
        writer.writeByte(1);
      case DateFormat.YYYYMMDD:
        writer.writeByte(2);
      case DateFormat.DDMMMYYYY:
        writer.writeByte(3);
      case DateFormat.DDMMYYYY:
        writer.writeByte(4);
      case DateFormat.defaultValue:
        writer.writeByte(5);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateFormatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocalStorageDtoAdapter extends TypeAdapter<LocalStorageDto> {
  @override
  final int typeId = 7;

  @override
  LocalStorageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStorageDto(
      createdAt: fields[0] as DateTime,
      updatedAt: fields[1] as DateTime,
      navigationTab: fields[3] as NavigationTab,
      didHappen: (fields[2] as List).cast<AuthStep>(),
      supportedLanguage: fields[4] as SupportedLanguage,
      turboThemeMode: fields[5] as TurboThemeMode,
      turboTheme: fields[6] as TurboTheme,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStorageDto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.didHappen)
      ..writeByte(3)
      ..write(obj.navigationTab)
      ..writeByte(4)
      ..write(obj.supportedLanguage)
      ..writeByte(5)
      ..write(obj.turboThemeMode)
      ..writeByte(6)
      ..write(obj.turboTheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TurboThemeAdapter extends TypeAdapter<TurboTheme> {
  @override
  final int typeId = 8;

  @override
  TurboTheme read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TurboTheme.blue;
      case 1:
        return TurboTheme.violet;
      case 2:
        return TurboTheme.zinc;
      case 3:
        return TurboTheme.defaultValue;
      default:
        return TurboTheme.blue;
    }
  }

  @override
  void write(BinaryWriter writer, TurboTheme obj) {
    switch (obj) {
      case TurboTheme.blue:
        writer.writeByte(0);
      case TurboTheme.violet:
        writer.writeByte(1);
      case TurboTheme.zinc:
        writer.writeByte(2);
      case TurboTheme.defaultValue:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TurboThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DateTimeAdapter extends TypeAdapter<DateTime> {
  @override
  final int typeId = 9;

  @override
  DateTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateTime(
      (fields[0] as num).toInt(),
      fields[1] == null ? 1 : (fields[1] as num).toInt(),
      fields[2] == null ? 1 : (fields[2] as num).toInt(),
      fields[3] == null ? 0 : (fields[3] as num).toInt(),
      fields[4] == null ? 0 : (fields[4] as num).toInt(),
      fields[5] == null ? 0 : (fields[5] as num).toInt(),
      fields[6] == null ? 0 : (fields[6] as num).toInt(),
      fields[7] == null ? 0 : (fields[7] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, DateTime obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.second)
      ..writeByte(6)
      ..write(obj.millisecond)
      ..writeByte(7)
      ..write(obj.microsecond);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
