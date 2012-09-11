CREATE OR REPLACE FUNCTION minhash (IN in_txt TEXT) RETURNS TEXT AS $$
DECLARE
    minhash TEXT := 'ffffffffffffffffffffffffffffffff';
    ngrams TEXT[];
    tmp TEXT;
BEGIN
    ngrams = show_trgm(in_txt);
    FOR i IN array_lower(ngrams, 1) .. array_upper(ngrams, 1)
    LOOP
        tmp = md5(ngrams[i]);
        IF tmp < minhash THEN
            minhash := tmp;
        END IF;
    END LOOP;
    RETURN minhash;
END;
$$ 
LANGUAGE plpgsql
IMMUTABLE;

