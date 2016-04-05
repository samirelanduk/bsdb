import unittest
from base import RootTest

class RootHtmlTest(RootTest):

    sponsor_urls = [
     "http://www.bbsrc.ac.uk/",
     "http://www.mrc.ac.uk/",
     "http://www.epsrc.ac.uk/",
     "http://www.ed.ac.uk/"
    ]

    def go_to_page(self, location, title, h1):
        # Go to the page
        self.browser.get(self.root_url + location)

        # Check the base
        self.check_current_page_base_html()

        # Check the title and h1
        self.check_title_and_h1(title, h1)


    def check_title_and_h1(self, title, h1):
        self.assertIn(
         title.lower(),
         self.browser.find_element_by_tag_name("title").get_attribute("innerHTML").lower()
        )
        self.assertIn(
         h1.lower(),
         self.browser.find_element_by_tag_name("h1").text.lower()
        )


    def check_current_page_base_html(self):
        # Title is fine
        self.assertIn(
         self.app_name,
         self.browser.find_element_by_tag_name("title").get_attribute("innerHTML").lower()
        )

        # Header is fine
        header = self.browser.find_element_by_tag_name("header")
        self.assertIn(self.app_name, header.text.lower())
        inputbox_div = header.find_element_by_id("omnisearch")
        inputbox = inputbox_div.find_element_by_tag_name("input")

        # Nav is fine
        nav = self.browser.find_element_by_tag_name("nav")
        nav_links = nav.find_elements_by_tag_name("a")
        for required_link in ["/", "/search", "/ligands", "/sequences", "/about"]:
            self.assertIn(
             self.root_url + required_link,
             [a.get_attribute("href") for a in nav_links]
            )

        # Footer is fine
        footer = self.browser.find_element_by_tag_name("footer")
        footer_links = footer.find_elements_by_tag_name("a")
        required_links = [
         "http://www.guidetopharmacology.org/",
         "/about",
         "/about/help",
         "/about/sponsors",
         "http://www.google.com/recaptcha/mailhide/d?k=01vYhjd4942K8mcJsTfn9STA"
         "==&c=gyybhwWR1ziUWzMMiVIf72wtrsNBtTCzJMQcN2lPmvi7B4vjy65HPFlKpsLE3rQ7",
         "/citing",
         "/privacy"
        ] + self.sponsor_urls
        for required_link in required_links:
            self.assertIn(
             self.root_url + required_link if required_link[0] == "/" else required_link,
             [a.get_attribute("href") for a in footer_links]
            )
