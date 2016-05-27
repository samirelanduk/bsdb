package org.bsdbmanage;

import javax.servlet.http.HttpServletRequest;

public class Utilities {

  public static String enclose(String element, String attributes, Object body) {
    return String.format(
     "<%s %s>%s</%s>",
     element,
     attributes,
     body == null ? "" : body.toString(),
     element
    );
  }


  public static boolean validMapId(HttpServletRequest request, String param) {
		String paramValue = request.getParameter(param);
		if (paramValue == null) {
			return false;
		}
		for (int i = 0; i < paramValue.length(); i++) {
			if (!("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(paramValue.subSequence(i, i+1)))) {
				return false;
			}
		}
		return true;
	}


  public static boolean validInteractionId(HttpServletRequest request, String param) {
		String paramValue = request.getParameter(param);
		if (paramValue == null) {
			return false;
		}
		for (int i = 0; i < paramValue.length(); i++) {
			if (!("0123456789".contains(paramValue.subSequence(i, i+1)))) {
				return false;
			}
		}
		return true;
	}


  public static boolean validPdbCode(HttpServletRequest request, String param) {
		String paramValue = request.getParameter(param);
		if (paramValue == null || paramValue.length() != 4) {
			return false;
		}
		for (int i = 0; i < paramValue.length(); i++) {
			if (!("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".contains(paramValue.subSequence(i, i+1)))) {
				return false;
			}
		}
		return true;
	}


  public static String sequenceToHtml(String sequence) {
    StringBuilder htmlSequence = new StringBuilder();
    for (char c : sequence.toCharArray()) {
      htmlSequence.append(Utilities.enclose("span", "class='letter'", c));
    }
    return htmlSequence.toString();
  }
}
