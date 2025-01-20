isMerged=0
mainHash=$(git rev-parse main)

for branch in $(git branch -a); do
    start=${branch:0:6}
    if [[ $start == "remote" && $branch != "remotes/origin/HEAD" && $branch != "remotes/origin/main" ]]; then
        branchHash=$(git rev-parse $branch)
        if [ $(git merge-base $mainHash $branchHash) == $branchHash ]; then
            let isMerged++
        else
            echo "Branch $branch is not merged"
        fi
    else
        :
    fi
done

echo "$isMerged branches are merged"
