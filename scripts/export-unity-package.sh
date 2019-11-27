#! /bin/sh

unity_username=$1
unity_password=$2
unity_serial=$3
project_path=$(pwd)/UnityGLTF
log_file=$(pwd)/build/unity-mac.log
export_path=$(pwd)/current-package/UnityGLTF.unitypackage

error_code=0

echo "Creating package."
# -username, -password, and -serial are all required to do the license activation from the
# command line.  License activation is required in order to use -batchmode (without deceptive errors).
# -nographics cannot be used with -serial
# https://forum.unity.com/threads/package-manager-failed-to-resolve-packages-packages-directory-does-not-exist.522782/
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -silent-crashes \
  -username "$unity_username" \
  -password "$unity_password" \
  -serial "$unity_serial" \
  -logFile "$log_file" \
  -projectPath "$project_path" \
  -exportPackage "Assets/UnityGLTF" "$export_path" \
  -returnlicense \
  -quit
if [ $? = 0 ] ; then
  echo "Created package successfully."
  error_code=0
else
  echo "Creating package failed. Exited with $?."
  error_code=1
fi

echo 'Build logs:'
cat $log_file

echo "Finishing with code $error_code"
exit $error_code