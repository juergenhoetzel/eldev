(require 'test/common)


(ert-deftest eldev-own-version-1 ()
  (eldev--test-run "project-a" ("version")
    (should (string= stdout (format "eldev %s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

(ert-deftest eldev-own-version-2 ()
  (eldev--test-run "project-a" ("version" "eldev")
    (should (string= stdout (format "eldev %s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

(ert-deftest eldev-own-version-3 ()
  (eldev--test-run "project-a" ("--quiet" "version")
    (should (string= stdout (format "%s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

(ert-deftest eldev-own-version-4 ()
  (eldev--test-run "project-a" ("--quiet" "version" "eldev")
    (should (string= stdout (format "%s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

;; Querying own version must work even from a non-project directory.
(ert-deftest eldev-own-version-5 ()
  (eldev--test-run "empty-project" ("version")
    (should (string= stdout (format "eldev %s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

(ert-deftest eldev-own-version-6 ()
  (eldev--test-run "empty-project" ("version" "eldev")
    (should (string= stdout (format "eldev %s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))

(ert-deftest eldev-own-version-missing-dependency-1 ()
  (eldev--test-run "missing-dependency-a" ("version")
    (should (string= stdout (format "eldev %s\n" (eldev-message-version (eldev-find-package-descriptor 'eldev)))))
    (should (= exit-code 0))))


(ert-deftest eldev-emacs-version-1 ()
  (eldev--test-run "project-a" ("version" "emacs")
    (should (string= stdout (format "emacs %s\n" emacs-version)))
    (should (= exit-code 0))))

(ert-deftest eldev-emacs-version-2 ()
  (eldev--test-run "project-a" ("--quiet" "version" "emacs")
    (should (string= stdout (format "%s\n" emacs-version)))
    (should (= exit-code 0))))

;; Querying Emacs version must work even from a non-project directory.
(ert-deftest eldev-emacs-version-3 ()
  (eldev--test-run "empty-project" ("version" "emacs")
    (should (string= stdout (format "emacs %s\n" emacs-version)))
    (should (= exit-code 0))))

(ert-deftest eldev-emacs-version-missing-dependency-1 ()
  (eldev--test-run "missing-dependency-a" ("version" "emacs")
    (should (string= stdout (format "emacs %s\n" emacs-version)))
    (should (= exit-code 0))))


(ert-deftest eldev-project-version-1 ()
  (eldev--test-run "project-a" ("version" "project-a")
    (should (string= stdout "project-a 1.0\n"))
    (should (= exit-code 0))))

(ert-deftest eldev-project-version-2 ()
  (eldev--test-run "project-a" ("--quiet" "version" "project-a")
    (should (string= stdout "1.0\n"))
    (should (= exit-code 0))))

(ert-deftest eldev-project-version-missing-dependency-1 ()
  (eldev--test-run "missing-dependency-a" ("version" "missing-dependency-a")
    (should (string= stdout "missing-dependency-a 1.0\n"))
    (should (= exit-code 0))))


(ert-deftest eldev-dependency-version-1 ()
  (eldev--test-run "project-a" ("version" "dependency-a")
    (should (string= stdout "dependency-a 1.0\n"))
    (should (= exit-code 0))))

(ert-deftest eldev-dependency-version-2 ()
  (eldev--test-run "project-a" ("--quiet" "version" "dependency-a")
    (should (string= stdout "1.0\n"))
    (should (= exit-code 0))))

(ert-deftest eldev-dependency-version-missing-dependency-1 ()
  ;; It might be installed by a different test that provides a
  ;; suitable archive in setup form.
  (let ((eldev--test-project "missing-dependency-a"))
    (eldev--test-delete-cache)
    (eldev--test-run nil ("version" "dependency-a")
      (should (string-match-p "dependency-a" stderr))
      (should (string= stdout ""))
      (should (= exit-code 1)))))


(ert-deftest eldev-multiple-versions-1 ()
  (eldev--test-run "project-a" ("version" "eldev" "emacs" "project-a" "dependency-a")
    (should (string= stdout (format "eldev %s\nemacs %s\nproject-a 1.0\ndependency-a 1.0\n"
                                    (eldev-message-version (eldev-find-package-descriptor 'eldev)) emacs-version)))
    (should (= exit-code 0))))

(ert-deftest eldev-multiple-versions-2 ()
  (eldev--test-run "project-a" ("--quiet" "version" "eldev" "emacs" "project-a" "dependency-a")
    (should (string= stdout (format "%s\n%s\n1.0\n1.0\n"
                                    (eldev-message-version (eldev-find-package-descriptor 'eldev)) emacs-version)))
    (should (= exit-code 0))))


(provide 'test/version)
