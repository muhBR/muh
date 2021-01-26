import React, { useEffect, useRef } from 'react'
import { useField } from '@unform/core'
import { Label, InputField } from '../styles/components/InputStyles'

interface Props {
  name: string
  label?: string
}

type InputProps = React.InputHTMLAttributes<HTMLInputElement> & Props

const Input: React.FC<InputProps> = ({ name, label, ...rest }) => {
  const inputRef = useRef<HTMLInputElement>(null)

  const { fieldName, defaultValue, registerField, error } = useField(name)

  useEffect(() => {
    registerField({
      name: fieldName,
      path: 'value',
      ref: inputRef.current
    })
  }, [fieldName, registerField])

  return (
    <>
      {label && <Label htmlFor="fieldName">{label}</Label>}

      <InputField
        id={fieldName}
        ref={inputRef}
        defaultValue={defaultValue}
        {...rest}
      />

      {error && <span>{error}</span>}
    </>
  )
}

export default Input
