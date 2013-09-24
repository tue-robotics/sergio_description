#! /bin/bash

ROBOT_DESCRIPTION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

# Generate urdf from xacro
rosrun xacro xacro.py -o $ROBOT_DESCRIPTION_DIR/urdf/amigo2.urdf $ROBOT_DESCRIPTION_DIR/urdf/xacro/amigo2.urdf.xacro

# Generate sdf from urdf
gzsdf print $ROBOT_DESCRIPTION_DIR/urdf/amigo2.urdf > $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf

grep 'Error' $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf
grep 'Warning' $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf

# Remove warning messages from sdf
sed -i '/Warning/d' $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf

# Fix media paths
sed -i 's/model:\/\/amigo_description\/media/model:\/\/media/g' $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf
sed -i 's/model:\/\/amigo2_description\/media/model:\/\/media/g' $ROBOT_DESCRIPTION_DIR/sdf/amigo2.sdf

