import optparse
import os
import re 
import fileinput
import parse 
import subprocess

def increase_build_number():
    pubspec_path = 'pubspec.yaml'

    new_content = ""
    with open(pubspec_path, 'r') as content_file:
        content = content_file.read()
        new_content = ""
        for line in content.splitlines():
            if 'version: ' in line: 
                res = parse.parse("version: {}.{}.{}+{}", line)
                version_code = int(res[3])
                version_code += 1
                major = version_code // 100
                version_code %= 100
                minor = version_code // 10
                patch = version_code % 10
                new_version = "version: {}.{}.{}+{}".format(major, minor, patch, version_code)
                new_content += new_version + '\n'
                print('Old {}, New {}'.format(line, new_version))
            else:
                new_content += line + '\n'
    with open(pubspec_path, 'w') as file:
        file.writelines(new_content)


def get_packages():
    subprocess.run(["flutter", "clean"])
    subprocess.run(["flutter", "packages", "get"])

def build(platform = 'all'):
    if platform == 'all':
        build_android()
        build_ios()
    elif platform == 'android':
        build_android()
    elif platform == 'ios':
        build_ios()


def build_android():
    subprocess.run(["flutter", "build", "appbundle", "-t", "lib/config/main_production.dart", "--flavor", "production"])


def build_ios():
    subprocess.run(["flutter", "build", "ios", "-t", "lib/config/main_production.dart", "--release", "--no-codesign"])


def upload_android(lane):
    os.chdir("android/")
    subprocess.run(["bundle", "exec", "fastlane", lane])
    os.chdir("../")


def upload_ios(lane):
    os.chdir("ios/")
    subprocess.run(["bundle", "exec", "fastlane", lane])
    os.chdir("../")


def run_tests():
    # subprocess.run(["flutter", "test", "test"], check=True)
    # subprocess.run(["flutter", "drive", "--target=test_driver/app.dart"], check=True)
    pass 


if __name__ == "__main__":
    parser = optparse.OptionParser()

    parser.add_option('-b', '--build',
        action="store", dest="query",
        help="build", default="beta")

    parser.add_option('-p', '--platform',
        action="store", dest="platform",
        help="platform", default="all")

    options, args = parser.parse_args()

    os.chdir("../")

    if options.query == 'prod':
        get_packages()
        build()
        upload_android('prod')
        upload_ios('prod')
        pass
    else:
        increase_build_number()
        run_tests()
        get_packages()
        build(options.platform)
        if options.platform == 'all':
            upload_android('beta')
            upload_ios('beta')
        elif options.platform == 'android':
            upload_android('beta')
        elif options.platform == 'ios':
            upload_ios('beta')
        else:
            print('unknown options')


