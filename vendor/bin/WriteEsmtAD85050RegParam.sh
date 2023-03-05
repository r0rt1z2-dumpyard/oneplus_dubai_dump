#/system/bin/sh

ExitProcess()
{
    exit $1;
}

#while read LINE; do
#    echo ${LINE}    # do something with it here
#done

LOCAL_RegParam_C_FilePath=/data/vendor/tmp/EsmtAD58050RegParam.c
LOCAL_RegParam_BIN_FilePath=/data/vendor/tmp/EsmtAD58050RegParam.bin
LOCAL_ExecResultFilePath=/data/vendor/tmp/OpTvApiCmdFifoResult.txt

rm -f ${LOCAL_RegParam_C_FilePath};
ProcessExitCode=$?
if [ ${ProcessExitCode} -ne 0 ]; then
    echo "del(${LOCAL_RegParam_C_FilePath}), err ${ProcessExitCode}"
    ExitProcess ${ProcessExitCode}
fi
cat > ${LOCAL_RegParam_C_FilePath}
ProcessExitCode=$?
if [ ${ProcessExitCode} -ne 0 ]; then
    echo "save stdin into a file, err ${ProcessExitCode}"
    ExitProcess ${ProcessExitCode}
fi

echo -n "EsmtAD85050_c_to_bin ${LOCAL_RegParam_C_FilePath} ${LOCAL_RegParam_BIN_FilePath};" > /data/vendor/tmp/halOpTvApiCmdFifo;
ProcessExitCode=$?
if [ ${ProcessExitCode} -ne 0 ]; then
    echo "conv c to bin, err ${ProcessExitCode}"
    ExitProcess ${ProcessExitCode}
fi
SECONDS=0
while [ 1 -eq 1 ]; do
	ls -l ${LOCAL_RegParam_BIN_FilePath};
	ProcessExitCode=$?
	if [ ${ProcessExitCode} -eq 0 ]; then
	    break
	fi
	if [ ${SECONDS} -ge 3 ]; then
	    echo "not produce correct ${LOCAL_RegParam_BIN_FilePath} in 3s, err ${ProcessExitCode}"
	    ExitProcess ${ProcessExitCode}
	fi
    usleep 10000
done

rm -f ${LOCAL_ExecResultFilePath};
ProcessExitCode=$?
if [ ${ProcessExitCode} -ne 0 ]; then
    echo "Failed to del LOCAL_ExecResultFilePath, err ${ProcessExitCode}"
    ExitProcess ${ProcessExitCode}
fi
echo -n "EsmtAD85050_DoInitSeq ${LOCAL_RegParam_BIN_FilePath} ${LOCAL_ExecResultFilePath};" > /data/vendor/tmp/halOpTvApiCmdFifo;
ProcessExitCode=$?
if [ ${ProcessExitCode} -ne 0 ]; then
    echo "EsmtAD85050_DoInitSeq, err ${ProcessExitCode}"
    ExitProcess ${ProcessExitCode}
fi
SECONDS=0
while [ 1 -eq 1 ]; do
	ls -l ${LOCAL_ExecResultFilePath};
	ProcessExitCode=$?
	if [ ${ProcessExitCode} -eq 0 ]; then
	    usleep 20000
		while read OneLine || [ -n "${OneLine}" ]; do
			nOutRet=`echo "${OneLine}" | grep "nOutRet:" | awk -F ' ' '{print $2;}'`
			ProcessExitCode=$?
			if [ ${ProcessExitCode} -eq 0 ]; then
				break
			fi
			nOutRet=
	    done < ${LOCAL_ExecResultFilePath}
	    if [ ! -z "${nOutRet}" ]; then
	    	break
	    fi
	fi
	if [ ${SECONDS} -ge 3 ]; then
	    echo "not produce correct ${LOCAL_ExecResultFilePath} in 3s, err ${ProcessExitCode}"
	    ExitProcess ${ProcessExitCode}
	fi
    usleep 50000
done

if [ "${nOutRet}" != "0" ]; then
	echo "nOutRet: ${nOutRet}"
	ExitProcess 1
fi

echo "done"
