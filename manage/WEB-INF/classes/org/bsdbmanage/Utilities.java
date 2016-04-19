package org.bsdbmanage;

public class Utilities {

  public static String enclose(String element, String attributes, String body) {
    return String.format("<%s %s>%s</%s>", element, attributes, body, element);
  }

}
