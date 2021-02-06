#!/bin/bash
rake db:drop
rake db:exists && rake db:migrate || rake db:setup

rails s -b 0
