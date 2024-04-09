DROP FUNCTION WCISMEDDET.GET_PROCEDURE_CODE;

CREATE OR REPLACE FUNCTION WCISMEDDET.get_PROCEDURE_CODE (
p_IDN IN NUMBER)
RETURN WCISMEDARC.PROCCODES IS
p_PROC WCISMEDARC.PROCCODES;
BEGIN                       

                           select cast(
                                      collect ( WCISMEDARC.PROCCD 
                                                (TO_NUMBER(SUBSTR(proc_colnum,(INSTR(proc_colnum,'CD_',1,2)+3),2),'99'),
                                              PROC_DATE,
                                              ICD9_PROC_CD,
                                              ICD10_PROC_CD)
                                              ) as WCISMEDARC.PROCCODES
                                     ) as PROC1
                            INTO p_PROC         
                            FROM TEMP_PROC_V
                            UNPIVOT            
                            ((PROC_DATE, ICD9_PROC_CD, ICD10_PROC_CD)  
                            for proc_colnum in ((PROC_DATE_1,ICD9_PROC_CD_1,ICD10_PROC_CD_1)
                                                           ,(PROC_DATE_2,ICD9_PROC_CD_2,ICD10_PROC_CD_2)
                                                           ,(PROC_DATE_3,ICD9_PROC_CD_3,ICD10_PROC_CD_3)
                                                           ,(PROC_DATE_4,ICD9_PROC_CD_4,ICD10_PROC_CD_4)
                                                           ,(PROC_DATE_5,ICD9_PROC_CD_5,ICD10_PROC_CD_5)
                                                           ,(PROC_DATE_6,ICD9_PROC_CD_6,ICD10_PROC_CD_6)
                                                           ,(PROC_DATE_7,ICD9_PROC_CD_7,ICD10_PROC_CD_7)
                                                           ,(PROC_DATE_8,ICD9_PROC_CD_8,ICD10_PROC_CD_8)
                                                           ,(PROC_DATE_9,ICD9_PROC_CD_9,ICD10_PROC_CD_9)
                                                           ,(PROC_DATE_10,ICD9_PROC_CD_10,ICD10_PROC_CD_10)
                                                           ,(PROC_DATE_11,ICD9_PROC_CD_11,ICD10_PROC_CD_11)
                                                           ,(PROC_DATE_12,ICD9_PROC_CD_12,ICD10_PROC_CD_12)
                                                           )
                              
                                ) where idn = p_IDN;                                                               
                               RETURN(p_PROC);
EXCEPTION
    WHEN others THEN  
                  proc_error_log(p_err_cd => sqlcode
                           ,p_err_txt => 'get_PROCEDURE failed'
                           ,p_sql_err_msg => sqlerrm);
                      --     CLOSE INSERT_BILLS_cur;
                           RAISE; 
END get_PROCEDURE_CODE;
/


GRANT EXECUTE ON WCISMEDDET.GET_PROCEDURE_CODE TO PUBLIC;
