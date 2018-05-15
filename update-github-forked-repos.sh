#!/bin/sh

DIR_NAME="github-repos"

OWNER="cantuariavc"

# Mantenha a mesma ordem das organizações para os repositórios
ORGS=("falko-org" "falko-org" "SaviorsServices" "Requisitos-Grupo1" "filipecaixeta" "MatheusRich")
REPOS=("Falko-API" "Falko" "CommunityService" "MatriculaWeb" "NeonEdgeGame" "dontfile")

CLONEWITH=2;      # 1 = Clone with HTTPS    2 = Clone with SSH

if [ "$CLONEWITH" -eq 1 ]
then
  CLONEWITHOPTION="https://github.com/"
elif [ "$CLONEWITH" -eq 2 ]
then
  CLONEWITHOPTION="git@github.com:"
fi

cd $HOME/Desktop/
if ! [ -d $DIR_NAME ]
then
	mkdir $DIR_NAME
fi

cd $DIR_NAME

for ((i=0; i<${#REPOS[@]}; i++))
do
  if ! [ -d ${REPOS[$i]} ]
  then
  	git clone $CLONEWITHOPTION$OWNER/${REPOS[$i]}.git
    cd ${REPOS[$i]}
    git remote add upstream $CLONEWITHOPTION${ORGS[$i]}/${REPOS[$i]}.git
  else
    cd ${REPOS[$i]}
  fi

  git fetch upstream master
  git reset --hard upstream/master
  git push -f
  cd ..
  # rm -rf ${repos[$x]}
done

# cd ..
#rm -rf GitHubRepos/
