view: RealisasiVSTarget{
  sql_table_name: `int-trial-gke.dm_ptpl.REALISASI_PRODUKSI`
    ;;

  dimension: kategori_grade {
    type: string
    sql: ${TABLE}.KATEGORI_GRADE ;;
  }

  dimension: kategori_kemasan {
    type: string
    sql: ${TABLE}.KATEGORI_KEMASAN ;;
  }

  dimension: material_desc {
    type: string
    sql: ${TABLE}.MATERIAL_DESC ;;
  }

  dimension: material_number {
    type: string
    sql: ${TABLE}.MATERIAL_NUMBER ;;
  }

  dimension: material_number_key {
    type: string
    sql: CONCAT(${material_number},${plant}, cast(extract(month from ${posting_date}) as string), cast(extract(year from ${posting_date}) as string) ) ;;
  }

  dimension: plant {
    type: string
    sql: ${TABLE}.PLANT ;;
  }

  dimension_group: posting {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.POSTING_DATE ;;
  }

  dimension: presentase_realisasi {
    type: number
    sql: ${TABLE}.PRESENTASE_REALISASI ;;
  }

  dimension: presentase_selisih {
    type: number
    sql: ${TABLE}.PRESENTASE_SELISIH ;;
  }

  dimension: realisasi {
    type: number
    sql: ${TABLE}.REALISASI ;;
  }

  dimension: selisih {
    type: number
    sql: ${TABLE}.SELISIH ;;
  }

  dimension: target {
    type: number
    sql: ${TABLE}.TARGET ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  ####################==============TAMBAHAN=====================#####################

  dimension: Month_Produksi {
    type: number
    sql:extract(month from ${posting_date});;

  }
  dimension: Year_Produksi {
    type: number
    sql: extract(year from ${posting_date}) ;;

  }

  dimension: title {
    type: string
     case: {
      when:{
      sql: right(${posting_month},2)='01' ;;
        label:"JANUARI"
        }
      when:{
        sql: right(${posting_month},2)='02' ;;
        label: "FEBRUARI"
      }
      when:{
        sql: right(${posting_month},2)='03' ;;
        label: "MARET"
      }
      when:{
        sql: right(${posting_month},2)='04' ;;
        label: "APRIL"
      }
      when:{
        sql: right(${posting_month},2)='05' ;;
        label: "MEI"
      }
      when:{
        sql: right(${posting_month},2)='06' ;;
        label: "JUNI"
      }
      when:{
        sql: right(${posting_month},2)='07' ;;
        label: "JULI"
      }
      when:{
        sql: right(${posting_month},2)='08' ;;
        label: "AGUSTUS"
      }
      when:{
        sql: right(${posting_month},2)='09' ;;
        label: "SEPTEMBER"
      }
      when:{
        sql: right(${posting_month},2)='10' ;;
        label: "OKTOBER"
      }
      when:{
        sql: right(${posting_month},2)='11' ;;
        label: "NOVEMBER"
      }
      when:{
        sql: right(${posting_month},2)='12' ;;
        label: "DESEMBER"
      }
      #else: "Not Defined"
    }

    html: <p><b><font color="black" size="10" >      PENCAPAIAN DASHBOARD {{rendered_value}}</font><b><p> ;;
  }

  dimension: TitleFul {
    type: string
    sql: concat(${title},' ',${posting_year}) ;;
    html: <p><b><font color="black" size="10" >      PENCAPAIAN  {{rendered_value}} PER KEMASAN</font><b><p> ;;
  }

  measure: sum_realisasi {
    type: sum
    sql: ${realisasi} ;;
    value_format_name: decimal_0
    drill_fields: [details*]
  }

  measure: sum_target {
    type: sum
    sql: ${target} ;;
  }

  measure: sum_selisih {
    type: sum
    sql: ${selisih} ;;
  }

  measure: percent_of_realization_calc {
    type: number
    value_format_name: percent_2
    sql: ${sum_realisasi}/${sum_target} ;;
  }

  measure: percent_of_diff_calc {
    type: number
    value_format_name: percent_2
    sql: ${sum_selisih}/${sum_target} ;;
  }



  set: details {
    fields: [material_number, plant,kategori_kemasan, kategori_grade,material_desc, target, realisasi, presentase_realisasi]
  }
}
