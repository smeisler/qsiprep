#!/bin/bash

cat << DOC

Test the BUAN Workflow
======================

BAUN tests!

Inputs:
-------

 - qsiprep single shell results (data/DSDTI_fmap)

DOC
set +e
source ./get_data.sh
TESTDIR=${PWD}
get_config_data ${TESTDIR}
get_bids_data ${TESTDIR} singleshell_output
CFG=${TESTDIR}/data/nipype.cfg
export FS_LICENSE=${TESTDIR}/data/license.txt

# Test MRtrix3 multishell msmt with ACT
TESTNAME=baun_test
setup_dir ${TESTDIR}/${TESTNAME}
TEMPDIR=${TESTDIR}/${TESTNAME}/work
OUTPUT_DIR=${TESTDIR}/${TESTNAME}/derivatives
BIDS_INPUT_DIR=${TESTDIR}/data/multishell_output/qsiprep
QSIPREP_CMD=$(run_qsiprep_cmd ${BIDS_INPUT_DIR} ${OUTPUT_DIR})

${QSIPREP_CMD} \
	 -w ${TEMPDIR} \
	 --recon-input ${BIDS_INPUT_DIR} \
	 --sloppy \
     --stop-on-first-crash \
	 --recon-spec dipy_baun_mrtrix_multishell_msmt_ACT-hsvs \
	 --recon-only \
	 -vv

