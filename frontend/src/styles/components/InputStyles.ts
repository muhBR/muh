import styled from 'styled-components'

export const Label = styled.label`
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
`

export const InputField = styled.input`
  border: 2px solid #ddd;
  border-radius: 4px;
  color: #444;
  font-size: 15px;
  margin-bottom: 15px;
  padding: 12px 16px;
  transition: border-color 0.2s;
  width: 100%;

  &:focus {
    border-color: #111;
  }
`
