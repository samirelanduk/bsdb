import unittest
from selenium import webdriver
import sys
import time

class RootTest(unittest.TestCase):

    root_url = "localhost:8080"
    if len(sys.argv) > 1:
        root_url = sys.argv[1]

    app_name = "bindsequencedb"
    root_url = "http://%s.%s" % (app_name, root_url)


    def setUp(self):
        self.browser = webdriver.Chrome()


    def tearDown(self):
        self.browser.quit()
