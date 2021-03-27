#!/bin/bash

pass=$(date +"%m%d%Y")
zip -mqr Koleksi.zip ./Kelinci* ./Kucing* -P $pass
