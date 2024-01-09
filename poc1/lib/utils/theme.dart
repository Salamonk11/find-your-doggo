import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Utility per il tema dell'app

/// Palette colori app
class Palette {
  /// Rosa
  static const primary = Color(0xFFBD6D84);

  /// Blu scuro
  static const secondary = Color(0xFF11235F);

  /// Bianco background
  static const background = Color(0xFFE8F4E4);

  // Porpora dettagli
  static const details = Color(0xFF771A34);

  /// Blu scuro testo
  static const text = Color(0xFF071834);
}

/// Contiene i pesi dei font
class Fonts {
  // ignore: public_member_api_docs
  static const FontWeight thin = FontWeight.w100;

  // ignore: public_member_api_docs
  static const FontWeight extraLight = FontWeight.w200;

  // ignore: public_member_api_docs
  static const FontWeight light = FontWeight.w300;

  // ignore: public_member_api_docs
  static const FontWeight regular = FontWeight.w400;

  // ignore: public_member_api_docs
  static const FontWeight medium = FontWeight.w500;

  // ignore: public_member_api_docs
  static const FontWeight semiBold = FontWeight.w600;

  // ignore: public_member_api_docs
  static const FontWeight bold = FontWeight.w700;

  // ignore: public_member_api_docs
  static const FontWeight extraBold = FontWeight.w800;

  // ignore: public_member_api_docs
  static const FontWeight black = FontWeight.w900;

  /// Restituisce un [FontWeight] dal suo [name], se esiste
  static FontWeight from(String name) {
    switch (name) {
      case 'thin':
        return thin;
      case 'extraLight':
        return extraLight;
      case 'light':
        return light;
      case 'regular':
        return regular;
      case 'medium':
        return medium;
      case 'semiBold':
        return semiBold;
      case 'bold':
        return bold;
      case 'extraBold':
        return extraBold;
      case 'black':
        return black;
      default:
        throw Exception('Missing fontSize $name');
    }
  }

  /// Stile utilizzato per appbar
  static TextStyle titleAppbar = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 20,
    fontWeight: Fonts.bold,
  );

  /// Stile utilizzato per titolo card
  static TextStyle titleCard = GoogleFonts.montserrat(
    color: Palette.text,
    fontSize: 20,
    fontWeight: Fonts.medium,
  );

  /// Stile utilizzato per titolo della sezione
  static TextStyle titleSection = GoogleFonts.montserrat(
    color: Palette.text,
    fontSize: 25,
    fontWeight: Fonts.semiBold,
  );

  /// Stile utilizzato per le info sottorazze all'interno delle sezioni razze
  static TextStyle infoSubbreeds = GoogleFonts.montserrat(
    color: Palette.details,
    fontSize: 20,
    fontWeight: Fonts.medium,
  );

  /// Stile utilizzato per le info sottorazze all'interno delle card
  static TextStyle infoSubbreedsCard = GoogleFonts.montserrat(
    color: Palette.secondary,
    fontSize: 15,
    fontWeight: Fonts.medium,
  );

  /// Stile utilizzato per il testo del primary button
  static TextStyle textPrimaryButton = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 15,
    fontWeight: Fonts.medium,
  );
}
