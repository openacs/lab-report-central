ad_library {

    Lab Report Central Install library
    
    Procedures that deal with installing, instantiating, mounting.

    @creation-date 2006-04-17
    @author Nick Carroll <ncarroll@ee.usyd.edu.au>
    @cvs-id $Id$
}


namespace eval lab_report_central::install {}

ad_proc -private lab_report_central::install::package_install {} {
    Package installation callback proc
} {
    db_transaction {
	lab_report_central::install::create_instructor_group
    }
}

ad_proc -private lab_report_central::install::create_instructor_group {} {
    Creates the lab group instructor type.
} {
    set magic_name "instructors"
    set group_id [group::new -group_name "[_ lab-report-central.instructor]"]

    db_dml insert {}
}
