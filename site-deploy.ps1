#!/usr/bin/env pwsh
surge site https://debian-rdx.surge.sh
scp -r site/* rauldipeas@web.sourceforge.net:/home/project-web/debian-rdx/htdocs