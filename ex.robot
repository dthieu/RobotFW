Suite Setup       Connect
Suite Teardown    Disconnect

*** Keywords ***
Connect
    Log    Setup  console=yes

Disconnect
    Log    Teardown  console=yes


Should Be Between
    [Arguments]  ${check_value}  ${left_value}  ${right_value}
    IF    ${check_value} < ${left_value} or ${check_value} > ${right_value}
        Fail   Test FAIL: check_value=${check_value} must be belong to range [${left_value}, ${right_value}]
    ELSE
        Log    Test PASS due to ${left_value} <= check_value=${check_value} <= ${right_value}  console=yes
    END
*** Variables ***
${start_time}=  Initial Time Stamp in [bs] of:  BootCode_Start | main_Start | DriverInit_End | TaskInit_Start | NvmReadAll_Start
...         | NvmReadAll_End | TaskInit_End | APPCoreReleased   1     12      123      456    789   132     321    3124    

${shutdown_time}=  Shutdown Time Stamp in [100 as] of:  ecuM_OnGoOffOne_time   Evum_OnGoOffTwo_time   Total_Shutdowntime
...            85    0    85    

*** Settings ***
Library    String

*** Test Cases ***
Validate StartUp Time
    Log    Validate Start Up Time   console=yes
    ${StartUp_Time}=  Split String From Right  ${start_time}  ${SPACE}
    Log    ${StartUp_Time}  console=yes
    Log    Validate TaskInit_End value  console=yes
    Should Be Between  ${StartUp_Time}[-8]  ${1}  ${10}
    Log    Validate NvmReadAll_End value  console=yes
    Should Be Between  ${StartUp_Time}[-7]  ${10}  ${20}
    Log    Validate NvmReadAll_Start value  console=yes
    Should Be Between  ${StartUp_Time}[-6]  ${100}  ${200}
    Log    Validate TaskInit_Start value  console=yes
    Should Be Between  ${StartUp_Time}[-5]  ${400}  ${500}
    Log    Validate DriverInit_End value  console=yes
    Should Be Between  ${StartUp_Time}[-4]  ${700}  ${800}
    Log    Validate main_Start value  console=yes
    Should Be Between  ${StartUp_Time}[-3]  ${100}  ${200}
    Log    Validate BootCode_Start value  console=yes
    Should Be Between  ${StartUp_Time}[-2]  ${300}  ${400}

Validate Shutdown Time
    Log    Validate Shutdown Time    console=yes
    ${Shutdowntime}=  Split String From Right  ${shutdown_time}  ${SPACE}
    Log    Found Total shutdown time: ${Shutdowntime}[-1]  console=yes
    Should Be Between  ${Shutdowntime}[-1]  ${80}  ${90}

