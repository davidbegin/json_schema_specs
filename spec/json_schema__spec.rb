require 'spec_helper'

describe 'JSON Schema' do
  describe 'validating for require fields' do
    it 'throws error if require field not present' do
      schema = {
         "required" => ["b"]
      }
      json = {"b" => "foo"}
      expect(JSON::Validator.validate(schema, json)).to be false
    end

    it 'returns true if all the fields are present' do
      schema = {
         "required" => ["a", "b"]
      }
      json = {}
      expect(JSON::Validator.validate(schema, json)).to be true
    end

    describe 'checking property type' do
      it 'validates array' do
        schema = {
          "properties"  => {
            "a" => { "type" => "array" }
          }
        }
        valid_json = {"a" => "[1,2,3]"}
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end

      it 'validates boolean' do 
        schema = {
          "properties"  => {
            "a" => { "type" => "boolean" }
          }
        }
        valid_json = {"a" => "woah"}
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end

      it 'validates number' do
        schema = {
          "properties"  => {
            "a" => { "type" => "number" }
          }
        }
        valid_json = {"a" => []}
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end

      it 'validates null' do
        schema = {
          "properties"  => {
            "a" => { "type" => "null" }
          }
        }
        valid_json = {"a" => 'null'}
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end

      it 'validates string' do
        schema = {
          "properties"  => {
            "a" => { "type" => "string" }
          }
        }
        valid_json = {"a" => 1997}
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end

      it 'validates object' do
        schema = {
          "title" => "valid object schema",
          "properties"  => {
            "a" => { "type" => "object" }
          }
        }
        valid_json = { "a" => [] }
        expect(JSON::Validator.validate(schema, valid_json)).to be true
      end
    end
  end

  describe '.validate!' do
    it 'raises an error if the json is not valid against the schema' do
        schema = {
          "properties"  => {
            "a" => { "type" => "string" }
          }
        }

        invalid_json = {"a" => "1"}

        expect do
          JSON::Validator.validate!(schema, invalid_json)
        end.to raise_error(JSON::Schema::ValidationError)
    end
  end
end
