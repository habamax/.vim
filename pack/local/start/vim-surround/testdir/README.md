# Surround tests

1. Clone vim's source code
2. Copy test file into `src/testdir/`
3. Add test entries to `src/testdir/Make_all.mak`:

        NEW_TESTS = \
            test_plugin_surround \

        NEW_TESTS_RES = \
            test_plugin_surround.res \

4. `cd src/testdir && make test_plugin_surround`
