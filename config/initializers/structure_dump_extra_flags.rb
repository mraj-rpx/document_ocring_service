core_tables = [
  '--table=core.pats_id_seq',
  '--table=core.pats'
]
ptab_tables = [
  '--table=ptab.ptab_case_details_id_seq',
  '--table=ptab.ptab_case_details',
  '--table=ptab.ptab_case_detail_party_types_id_seq',
  '--table=ptab.ptab_case_detail_party_types',
  '--table=ptab.ptab_cases_id_seq',
  '--table=ptab.ptab_cases'
]

acq_tables = [
  '--table=acquiflow.manual_assets_id_seq',
  '--table=acquiflow.manual_assets'
]

docdb_tables = [
  '--table=docdb.docdb_pats_id_seq',
  '--table=docdb.docdb_pats'
]

ocr_tables = [
  '--table=document_ocr_service.*'
]
ActiveRecord::Tasks::DatabaseTasks.structure_dump_flags = core_tables + ptab_tables + acq_tables + docdb_tables + ocr_tables
