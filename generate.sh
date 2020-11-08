#!/bin/bash

cat <<EOF
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>EVE Asset Safety</title>
    <style type="text/css">
        table {
            border-collapse: collapse;
            border-spacing: 0;
            empty-cells: show;
        }
        td {
            padding-left: 5px;
        }
    </style>

    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>

    <script type="text/javascript">
        \$(document).ready( function () {
            \$('#thetable').DataTable( {
                "pageLength": -1,
                "lengthMenu": [[50, 100, 250, 500, -1], [50, 100, 250, 500, 'All']],
                "columnDefs": [{targets: [0,2,3,5,6], className: "dt-body-right",}],
            } );
        } );
    </script>
</head>

<body>
    <table id="thetable" class="display">
        <caption>
            EVE Online asset safety places goods from the following systems into the listed destination systems.
        </caption>
        <colgroup>
            <col span="3" class="sourceSystem">
            <col span="3" class="destSystem">
            <col>
        </colgroup>
        <thead>
            <tr>
                <th colspan="3">Source System</th>
                <th colspan="3">Destination System</th>
            </tr>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Name</th>
                <th scope="col">Security</th>
                <th scope="col">ID</th>
                <th scope="col">Name</th>
                <th scope="col">Security</th>
                <th scope="col">distance</th>
            </tr>
        </thead>
        <tbody>
EOF

sqlite3 sqlite-latest.sqlite -cmd '.mode html' < distance.sql

cat <<EOF
        </tbody>
    </table>
</body>

</html>
EOF