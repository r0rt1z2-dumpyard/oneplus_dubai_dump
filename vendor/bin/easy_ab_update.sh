#!/system/bin/sh

typeset -i ota_package_count=0
typeset -i metadata_file_offset=0

OTA_PACKAGE_PATH="/storage/*/*.zip"
OTA_METADATA_PATH="META-INF/com/android/metadata"

if [ $# -gt 1 ]; then
    echo -e "Error: Wrong number of parameters !!\n";
    echo -e "Usage: easy_ab_update.sh [path/to/ota_package]\n";
    echo -e "Trigger the A/B system update used a local OTA package(*.zip).";
    echo -e "[path/to/ota_package] is optional, default to scan the U-disk.\n";
    exit 0;
fi

if [ "$1" == "--help" ]; then
    echo -e "Usage: easy_ab_update.sh [path/to/ota_package]\n";
    echo -e "Trigger the A/B system update used a local OTA package(*.zip).";
    echo -e "[path/to/ota_package] is optional, default to scan the U-disk.\n";
    exit 0;
fi

if [ "$1" != "" ]; then

    zip_file_path=$(cd $(dirname $1); pwd;)
    zip_file_name=$(basename $1)
    zip_file=${zip_file_path}/${zip_file_name}

    if [ ! -f ${zip_file} ]; then
        echo -e "${zip_file} is not existed !!"
        exit 0;
    fi

    metadata_path=$(dd if=${zip_file} bs=1 count=29 skip=30)

    if [ "${metadata_path}" != "${OTA_METADATA_PATH}" ]; then
        echo -e "${zip_file} is not a valid OTA package for A/B system update !!"
        exit 0;
    fi

else

    zip_file_list=${OTA_PACKAGE_PATH}

    if [ ${zip_file_list} != "${OTA_PACKAGE_PATH}" ]; then
        for zip_file in ${zip_file_list};
        do
            metadata_path=$(dd if=${zip_file} bs=1 count=29 skip=30)
            if [ "${metadata_path}" == "${OTA_METADATA_PATH}" ]; then
                ota_package_count=ota_package_count+1
            fi
        done
    fi

    if [ ${ota_package_count} -eq 0 ]; then
        echo -e "There is no valid OTA package in the root directory of U-disk !!"
        exit 0
    else
        if [ ${ota_package_count} -ne 1 ]; then
            echo -e "There are too many OTA package in the root directory of U-disk !!"
            exit 0
        fi
    fi

fi

metadata_path_length=$(od -An -tu -j26 -N2 ${zip_file})
zip_extra_field_length=$(od -An -tu -j28 -N2 ${zip_file})

metadata_file_offset=30+${metadata_path_length}+${zip_extra_field_length}
metadata_file_lengh=$(od -An -tu -j18 -N4 ${zip_file})

metadata_file=$(dd if=${zip_file} bs=1 count=$(echo -e ${metadata_file_lengh}) skip=$(echo -e ${metadata_file_offset}))

payload_offset=${metadata_file#*"payload.bin:"}
payload_offset=${payload_offset%%":"*}

payload_properties_offset=${metadata_file#*"payload_properties.txt:"}
payload_properties_offset=${payload_properties_offset%%":"*}

payload_properties_size=${metadata_file#*"payload_properties.txt:"}
payload_properties_size=${payload_properties_size#*":"}
payload_properties_size=${payload_properties_size%%","*}

payload_properties_file=$(dd if=${zip_file} bs=1 count=${payload_properties_size} skip=${payload_properties_offset})

echo -e "\nTrying to use ${zip_file} to do A/B system update.\n"

logcat -c

{
    logcat -s update_engine
}&

logcat_pid=$!

# Run the update device command now !!
update_engine_client \
--follow \
--update \
--offset=${payload_offset} \
--payload=file://${zip_file} \
--headers="${payload_properties_file}"

# wait the logcat thread complete.
sleep 2s

# kill the logcat thread.
kill -9 ${logcat_pid}

