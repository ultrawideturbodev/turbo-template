// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'nl';

  static String m0(username) => "👋 Hallo @${username}";

  static String m1(email) =>
      "Als ${email} bij ons is geregistreerd, is er een e-mail verzonden om het wachtwoord te resetten.";

  static String m2(kLimitsMaxNameLength) =>
      "Name can be at most ${kLimitsMaxNameLength} characters long.";

  static String m3(username) => "${username}\'s Household";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "alreadyInUse": MessageLookupByLibrary.simpleMessage("Al in gebruik"),
        "anErrorOccurredWhileTryingToLogoutPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Er is een fout opgetreden bij het uitloggen. Probeer het later opnieuw."),
        "anUnknownErrorOccurredPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Er is een onbekende fout opgetreden. Probeer het later opnieuw."),
        "and": MessageLookupByLibrary.simpleMessage("en"),
        "apr": MessageLookupByLibrary.simpleMessage("apr"),
        "april": MessageLookupByLibrary.simpleMessage("april"),
        "areYouSureYouWantToLeaveThisHousehold":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to leave this household?"),
        "areYouSureYouWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Weet je zeker dat je wilt uitloggen?"),
        "areYouSureYouWantToRemoveThisMember":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to remove this member?"),
        "aug": MessageLookupByLibrary.simpleMessage("aug"),
        "august": MessageLookupByLibrary.simpleMessage("augustus"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuleren"),
        "changeName": MessageLookupByLibrary.simpleMessage("Change Name"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord wijzigen"),
        "clickHereToLogin":
            MessageLookupByLibrary.simpleMessage("Klik hier om in te loggen"),
        "confirmYourPassword":
            MessageLookupByLibrary.simpleMessage("Bevestig je wachtwoord"),
        "create": MessageLookupByLibrary.simpleMessage("Aanmaken"),
        "createShoppingList":
            MessageLookupByLibrary.simpleMessage("Boodschappenlijst aanmaken"),
        "databaseFailure":
            MessageLookupByLibrary.simpleMessage("Database fout"),
        "dec": MessageLookupByLibrary.simpleMessage("dec"),
        "december": MessageLookupByLibrary.simpleMessage("december"),
        "deletingFailed":
            MessageLookupByLibrary.simpleMessage("Verwijderen mislukt"),
        "dutch": MessageLookupByLibrary.simpleMessage("Nederlands"),
        "editLanguage": MessageLookupByLibrary.simpleMessage("Taal aanpassen"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "emailHint": MessageLookupByLibrary.simpleMessage("jouw@email.com"),
        "emailNotYetVerified": MessageLookupByLibrary.simpleMessage(
            "E-mail nog niet geverifieerd"),
        "emailVerified":
            MessageLookupByLibrary.simpleMessage("E-mail geverifieerd"),
        "emptyPlaceholderAnEmptyList": MessageLookupByLibrary.simpleMessage(
            "Een lege lijst is als een heldere hemel; wat ga jij bouwen?"),
        "emptyPlaceholderBlankCanvas": MessageLookupByLibrary.simpleMessage(
            "Een blanco canvas wacht op jouw meesterwerk."),
        "emptyPlaceholderEmptySpaces": MessageLookupByLibrary.simpleMessage(
            "Lege ruimtes zijn gewoon plekken voor groei."),
        "emptyPlaceholderNoEntries": MessageLookupByLibrary.simpleMessage(
            "Nog geen items, maar oneindig potentieel."),
        "emptyPlaceholderNotAVoid": MessageLookupByLibrary.simpleMessage(
            "Dit is geen leegte, het is een podium."),
        "emptyPlaceholderNotSadJustEmpty": MessageLookupByLibrary.simpleMessage(
            "Niet droevig, maar gewoon leeg."),
        "emptyPlaceholderNothingHere": MessageLookupByLibrary.simpleMessage(
            "Niets hier behalve mogelijkheden."),
        "emptyPlaceholderTheEmptiness": MessageLookupByLibrary.simpleMessage(
            "De leegte die je ziet is de ruimte voor je volgende prestatie."),
        "emptyPlaceholderTheEmptinessIsNotALack":
            MessageLookupByLibrary.simpleMessage(
                "De leegte is geen gebrek, maar een ruimte om te vullen."),
        "emptyPlaceholderZeroItems": MessageLookupByLibrary.simpleMessage(
            "Nul items, eindeloze mogelijkheden."),
        "english": MessageLookupByLibrary.simpleMessage("Engels"),
        "enterAValidEmail": MessageLookupByLibrary.simpleMessage(
            "Voer een geldig e-mailadres in"),
        "enterTheNameForTheNewShoppingList": MessageLookupByLibrary.simpleMessage(
            "Voer de naam in voor de nieuwe boodschappenlijst. Dit zal zichtbaar zijn voor alle leden."),
        "enterTheNewNameForTheHouseholdThisWillBe":
            MessageLookupByLibrary.simpleMessage(
                "Enter the new name for the household. This will be visible to all members."),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("Voer je e-mailadres in"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Voer je wachtwoord in"),
        "failedToAcceptInvitePleaseTryAgainLaterAndContact":
            MessageLookupByLibrary.simpleMessage(
                "Failed to accept invite, please try again later and contact us if the problem persists."),
        "failedToDeclineInviteRightNowPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Failed to decline invite right now, please try again later and contact us if the problem persist."),
        "failedToRemoveMemberRightNowPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Failed to remove member right now. Please try again later."),
        "feb": MessageLookupByLibrary.simpleMessage("feb"),
        "february": MessageLookupByLibrary.simpleMessage("februari"),
        "fillInYourEmail":
            MessageLookupByLibrary.simpleMessage("Vul je e-mailadres in"),
        "fillInYourEmailAddressAndWeWillSendYou":
            MessageLookupByLibrary.simpleMessage(
                "Vul je e-mailadres in en we sturen je een link om je wachtwoord te resetten."),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord vergeten"),
        "fri": MessageLookupByLibrary.simpleMessage("vr"),
        "friday": MessageLookupByLibrary.simpleMessage("vrijdag"),
        "helloUsername": m0,
        "home": MessageLookupByLibrary.simpleMessage("Thuis"),
        "household": MessageLookupByLibrary.simpleMessage("Huishouden"),
        "householdNameMustBeAtLeast3CharactersLong":
            MessageLookupByLibrary.simpleMessage(
                "Household name must be at least 3 characters long"),
        "householdNameMustBeAtMost50CharactersLong":
            MessageLookupByLibrary.simpleMessage(
                "Household name must be at most 50 characters long"),
        "ifRegisteredWeSend": m1,
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "invite": MessageLookupByLibrary.simpleMessage("Invite"),
        "inviteHouseholdMessage": MessageLookupByLibrary.simpleMessage(
            "Portal legendary it people clearly sanskrit theorists worm hole origin sky visitors times origin soloman manipulation."),
        "jan": MessageLookupByLibrary.simpleMessage("jan"),
        "january": MessageLookupByLibrary.simpleMessage("januari"),
        "jul": MessageLookupByLibrary.simpleMessage("jul"),
        "july": MessageLookupByLibrary.simpleMessage("juli"),
        "jun": MessageLookupByLibrary.simpleMessage("jun"),
        "june": MessageLookupByLibrary.simpleMessage("juni"),
        "language": MessageLookupByLibrary.simpleMessage("Taal"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "leaveHousehold":
            MessageLookupByLibrary.simpleMessage("Leave Household"),
        "login": MessageLookupByLibrary.simpleMessage("Inloggen"),
        "logout": MessageLookupByLibrary.simpleMessage("Uitloggen"),
        "logoutFailed":
            MessageLookupByLibrary.simpleMessage("Uitloggen mislukt"),
        "mar": MessageLookupByLibrary.simpleMessage("mrt"),
        "march": MessageLookupByLibrary.simpleMessage("maart"),
        "maximumHouseholdMembersReached": MessageLookupByLibrary.simpleMessage(
            "Maximum aantal huishoudleden bereikt"),
        "may": MessageLookupByLibrary.simpleMessage("mei"),
        "member": MessageLookupByLibrary.simpleMessage("Lid"),
        "memberRemoved":
            MessageLookupByLibrary.simpleMessage("Member removed!"),
        "members": MessageLookupByLibrary.simpleMessage("Leden"),
        "mon": MessageLookupByLibrary.simpleMessage("ma"),
        "monday": MessageLookupByLibrary.simpleMessage("maandag"),
        "myHousehold": MessageLookupByLibrary.simpleMessage("My Household"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameCanBeAtMostKlimitsmaxnamelengthCharactersLong": m2,
        "noResultsPlaceholderAnEmptyList": MessageLookupByLibrary.simpleMessage(
            "Een lege lijst is een uitnodiging voor nieuwe perspectieven."),
        "noResultsPlaceholderConsiderADifferent":
            MessageLookupByLibrary.simpleMessage(
                "Overweeg een andere aanpak of term."),
        "noResultsPlaceholderEmbraceThis": MessageLookupByLibrary.simpleMessage(
            "Omarm deze lege lijst als een moment van rust."),
        "noResultsPlaceholderInThisMoment":
            MessageLookupByLibrary.simpleMessage(
                "Op dit moment zijn er geen resultaten."),
        "noResultsPlaceholderMaybeWhatYoureLooking":
            MessageLookupByLibrary.simpleMessage(
                "Misschien is wat je zoekt verborgen in een ander perspectief."),
        "noResultsPlaceholderNoAnswers":
            MessageLookupByLibrary.simpleMessage("Geen antwoorden hier."),
        "noResultsPlaceholderNoMatches": MessageLookupByLibrary.simpleMessage(
            "Geen overeenkomsten hier. Heroverweeg je zoekopdracht."),
        "noResultsPlaceholderNoResults":
            MessageLookupByLibrary.simpleMessage("Geen resultaten gevonden."),
        "noResultsPlaceholderNothingFound":
            MessageLookupByLibrary.simpleMessage("Niets gevonden."),
        "noResultsPlaceholderNothingMatched":
            MessageLookupByLibrary.simpleMessage(
                "Niets komt overeen met je zoekopdracht."),
        "noResultsPlaceholderPerhapsItsTime":
            MessageLookupByLibrary.simpleMessage(
                "Misschien is het tijd om een andere vraag te stellen."),
        "noResultsPlaceholderPerhapsItsTimeToTake":
            MessageLookupByLibrary.simpleMessage(
                "Misschien is het tijd om een andere route te nemen."),
        "noResultsPlaceholderPerhapsTheAnswer":
            MessageLookupByLibrary.simpleMessage(
                "Misschien ligt het antwoord ergens anders."),
        "noResultsPlaceholderSeekInAnother":
            MessageLookupByLibrary.simpleMessage(
                "Zoek in een andere richting met scherpere focus."),
        "noResultsPlaceholderTheOutcome": MessageLookupByLibrary.simpleMessage(
            "Het resultaat is duidelijk: niets gevonden. Hoe ga je je aanpassen?"),
        "noResultsPlaceholderTheSearchIsOver":
            MessageLookupByLibrary.simpleMessage(
                "De zoektocht is voorbij, maar de reis gaat door."),
        "noResultsPlaceholderTheSearchReveals":
            MessageLookupByLibrary.simpleMessage(
                "De zoektocht onthult afwezigheid."),
        "nov": MessageLookupByLibrary.simpleMessage("nov"),
        "november": MessageLookupByLibrary.simpleMessage("november"),
        "oct": MessageLookupByLibrary.simpleMessage("okt"),
        "october": MessageLookupByLibrary.simpleMessage("oktober"),
        "ok": MessageLookupByLibrary.simpleMessage("Oké"),
        "or": MessageLookupByLibrary.simpleMessage("of"),
        "password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
        "passwordDoesNotMatch": MessageLookupByLibrary.simpleMessage(
            "Wachtwoord komt niet overeen"),
        "pending": MessageLookupByLibrary.simpleMessage("In afwachting"),
        "pleaseCheckYourEmailToVerifyYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "Controleer je e-mail om je account te verifiëren."),
        "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Voer een geldig e-mailadres in"),
        "pleaseReadAndAcceptOurPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage(
                "Lees en accepteer ons privacybeleid"),
        "privacyPolicyAndTermsOfServiceAccepted":
            MessageLookupByLibrary.simpleMessage(
                "Privacybeleid en servicevoorwaarden geaccepteerd"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeMember": MessageLookupByLibrary.simpleMessage("Remove member"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("Wachtwoord resetten"),
        "sat": MessageLookupByLibrary.simpleMessage("za"),
        "saturday": MessageLookupByLibrary.simpleMessage("zaterdag"),
        "search": MessageLookupByLibrary.simpleMessage("Zoeken"),
        "send": MessageLookupByLibrary.simpleMessage("Verzenden"),
        "sendEmail": MessageLookupByLibrary.simpleMessage("E-mail verzenden"),
        "sep": MessageLookupByLibrary.simpleMessage("sep"),
        "september": MessageLookupByLibrary.simpleMessage("september"),
        "settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
        "shoppingList":
            MessageLookupByLibrary.simpleMessage("Boodschappenlijst"),
        "skip": MessageLookupByLibrary.simpleMessage("Overslaan"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Er is iets misgegaan"),
        "somethingWentWrongPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Er is iets misgegaan, probeer het later opnieuw."),
        "somethingWentWrongWhileDeletingOldUsernamesPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Er is iets misgegaan bij het verwijderen van oude gebruikersnamen, probeer het opnieuw."),
        "somethingWentWrongWhileTryingToCreateYourProfilePlease":
            MessageLookupByLibrary.simpleMessage(
                "Er is iets misgegaan bij het aanmaken van je profiel, probeer het opnieuw."),
        "stranger": MessageLookupByLibrary.simpleMessage("vreemdeling"),
        "sun": MessageLookupByLibrary.simpleMessage("zo"),
        "sunday": MessageLookupByLibrary.simpleMessage("zondag"),
        "thisFieldIsRequired":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "thu": MessageLookupByLibrary.simpleMessage("do"),
        "thursday": MessageLookupByLibrary.simpleMessage("donderdag"),
        "titleMustBeAtLeast1CharacterLong":
            MessageLookupByLibrary.simpleMessage(
                "Title must be at least 1 character long."),
        "tue": MessageLookupByLibrary.simpleMessage("di"),
        "tuesday": MessageLookupByLibrary.simpleMessage("dinsdag"),
        "unableToAcceptPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Kan niet accepteren, probeer het later opnieuw."),
        "unavailable": MessageLookupByLibrary.simpleMessage("Niet beschikbaar"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "unknownError": MessageLookupByLibrary.simpleMessage("Onbekende fout"),
        "userIsAlreadyAMember":
            MessageLookupByLibrary.simpleMessage("Gebruiker is al lid"),
        "userIsAlreadyInvited":
            MessageLookupByLibrary.simpleMessage("Gebruiker is al uitgenodigd"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Gebruiker niet gevonden"),
        "username": MessageLookupByLibrary.simpleMessage("Gebruikersnaam"),
        "usernameFieldHint": MessageLookupByLibrary.simpleMessage("@turbodoe"),
        "usernameFieldLabel": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameIsAlreadyInUsePleaseChooseADifferentOne":
            MessageLookupByLibrary.simpleMessage(
                "Gebruikersnaam is al in gebruik, kies een andere."),
        "usernameIsAlreadyTaken": MessageLookupByLibrary.simpleMessage(
            "Gebruikersnaam is al in gebruik."),
        "usernamesHousehold": m3,
        "verificationEmailSent": MessageLookupByLibrary.simpleMessage(
            "Verificatie-e-mail verzonden"),
        "verifyEmail":
            MessageLookupByLibrary.simpleMessage("E-mail verifiëren"),
        "weHaveResentTheVerificationEmailPleaseCheckYourInbox":
            MessageLookupByLibrary.simpleMessage(
                "We hebben de verificatie-e-mail opnieuw verzonden. Controleer je inbox en probeer het opnieuw."),
        "weNoticedYouHaveNotVerifiedYourEmailAddressYet":
            MessageLookupByLibrary.simpleMessage(
                "We zien dat je je e-mailadres nog niet hebt geverifieerd. Controleer je inbox en volg de instructies om je e-mailadres te verifiëren."),
        "wed": MessageLookupByLibrary.simpleMessage("wo"),
        "wednesday": MessageLookupByLibrary.simpleMessage("woensdag"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welkom"),
        "whatNameSuitsYouBest": MessageLookupByLibrary.simpleMessage(
            "Welke naam past het beste bij jou?"),
        "youHaveLeftTheHousehold":
            MessageLookupByLibrary.simpleMessage("You have left the household"),
        "youWillNoLongerHaveAccessToThisHouseholdYou":
            MessageLookupByLibrary.simpleMessage(
                "Je bent automatisch teruggekeerd naar je oude huishouden als je dat had."),
        "yourPasswordMustBeAtLeast8CharactersLong":
            MessageLookupByLibrary.simpleMessage(
                "Je wachtwoord moet minimaal 8 tekens lang zijn.")
      };
}
