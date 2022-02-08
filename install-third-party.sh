for f in $(ls third-party/*.yaml); do
  oc apply -f $f
done
