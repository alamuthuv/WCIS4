DROP FUNCTION WCISMEDDET.GET_OTPT_CODE;

CREATE OR REPLACE FUNCTION WCISMEDDET.get_OTPT_CODE (
p_IDN IN NUMBER)
RETURN WCISMEDARC.OTPTCODES IS
p_OTPT WCISMEDARC.OTPTCODES;
BEGIN                       

                          select cast(
                                      collect ( WCISMEDARC.OTPTCD 
                                                (TO_NUMBER(SUBSTR(OTPT_colnum,(INSTR(OTPT_colnum,'_',1,10)+4),2),'99'),
                                              OTPT_ICD9_CD,
                                              OTPT_ICD10_CD)
                                              ) as WCISMEDARC.OTPTCODES
                                     ) as OTPT1
                            INTO p_OTPT         
                            FROM TEMP_OTPT_V
                            UNPIVOT          
                            ((OTPT_ICD9_CD, OTPT_ICD10_CD)  
                            for OTPT_colnum in ((OTPT_VISIT_RSN_ICD9_CD_1,OTPT_VISIT_RSN_ICD10_CD_1)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_2,OTPT_VISIT_RSN_ICD10_CD_2)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_3,OTPT_VISIT_RSN_ICD10_CD_3)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_4,OTPT_VISIT_RSN_ICD10_CD_4)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_5,OTPT_VISIT_RSN_ICD10_CD_5)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_6,OTPT_VISIT_RSN_ICD10_CD_6)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_7,OTPT_VISIT_RSN_ICD10_CD_7)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_8,OTPT_VISIT_RSN_ICD10_CD_8)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_9,OTPT_VISIT_RSN_ICD10_CD_9)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_10,OTPT_VISIT_RSN_ICD10_CD_10)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_11,OTPT_VISIT_RSN_ICD10_CD_11)
                                                           ,(OTPT_VISIT_RSN_ICD9_CD_12,OTPT_VISIT_RSN_ICD10_CD_12)
                                                           )
                              
                                ) where idn = p_IDN;                                                             
                               RETURN(p_OTPT);
EXCEPTION
    WHEN others THEN  
                  proc_error_log(p_err_cd => sqlcode
                           ,p_err_txt => 'get_OTPT failed'
                           ,p_sql_err_msg => sqlerrm);
                       --    CLOSE INSERT_BILLS_cur;
                           RAISE; 
END get_OTPT_CODE;
/


GRANT EXECUTE ON WCISMEDDET.GET_OTPT_CODE TO PUBLIC;
