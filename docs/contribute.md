## Welcome to the microsoft_teams_clone contributor's wiki!
Thanks for your interest in contributing to this project.

## Prerequisites
1. Good internet connectivity is required as this project uses third party libraries which will be needed to build the app.
2. Download/Install latest [VS Code](https://code.visualstudio.com/download) or [Android Studio](https://developer.android.com/studio/?gclid=EAIaIQobChMI8fX3n5Lb6AIVmH8rCh24JQsxEAAYASAAEgL4L_D_BwE&gclsrc=aw.ds#downloads).

## Project Setup
Refer [Project Setup](https://github.com/Karanjot-singh/microsoft_teams_clone/wiki/)

## Instructions for making a code change

**Working on your first Pull Request?** You can learn how from this free series: [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github).

The following instructions describe how to make a one-off code change using a feature branch. (In case you're interested, we mainly use the [Gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow).) Please follow them carefully, otherwise your code review may be delayed.

1. **Choose a descriptive branch name.** It should be lowercase and hyphen-separated, such as `splash-screen`. Also, it shouldn't start with `hotfix` or `release`.
2. **Before coding anything, create a new branch with this name, starting from 'develop'.** I.e., run:

    ```
      git fetch upstream
      git checkout develop
      git merge upstream/develop
      git checkout -b your-branch-name
    ```

3. **Make commit(s) to your feature branch.** Each commit should be self-contained and have a descriptive commit message that helps other developers understand why the changes were made. However, **do not write "Fix #ISSUE_NUMBER"** (e.g. Fix #99999) in your commit messages, as this will cause Github to close the original issue automatically. You can rename your commit messages using `git commit --amend`.

    * Before making the commit, do some sanity-checks:
       * Start up a local instance do some manual testing in order to check that you haven't broken anything!
       * Ensure that your code follows the [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) and that it is well-tested.
      * Use a tool like `git diff` or `meld` to check that the changes you've made are exactly what you want them to be, and that you haven't left in anything spurious. Make sure to do this _before_ you push.

    * To actually make the commit and push it to your GitHub fork, run:

        ```
          git commit -a -m "{{YOUR COMMIT MESSAGE HERE}}"
          git push origin {{YOUR BRANCH NAME}}
        ```

4. **When your feature is ready to merge, create a pull request.**
    * Go to your fork on GitHub, select the develop branch from the dropdown menu, and click "pull request".
    * Add a descriptive title explaining the purpose of the PR (e.g. "Fix issue #bugnum: add a warning when the user leaves a page in the middle of an exploration.").
5. #### **Address review comments until the reviewers give LGTM ('looks good to me').** 

6. **Tidy up!** After the PR status has changed to "Merged", delete the feature branch from both your local clone and the GitHub repository:

     ```
       git branch -D new-branch-name
       git push origin --delete new-branch-name
     ```

7. **Celebrate.** Congratulations, you have contributed to this project!
