#!/usr/bin/env python
import re, os

def filter_folder(foldername):
  return foldername in ['[Gmail]/All Mail'
                       ,'[Gmail]/Sent Mail'
                       ]

def name_trans(foldername):
  foldername = re.sub('^\[Gmail\]/All Mail$', 'all', foldername)
  foldername = re.sub('^\[Gmail\]/Sent Mail$', 'sent', foldername)
  return foldername

def get_authinfo_password(machine, login, port):
  s = "machine %s login %s password ([^ ]*) port %s" % (machine, login, port)
  p = re.compile(s)
  authinfo = os.popen("gpg2 -q --no-tty -d ~/.authinfo.gpg").read()
  return p.search(authinfo).group(1)
